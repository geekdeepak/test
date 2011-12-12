class ProjectsController < ApplicationController
  
  before_filter :require_user
  before_filter :require_owner, :except => [:new, :create, :destroy, :index, :confirm, :add_to_life]
  before_filter :dont_display_projects, :only => [:index]
  
  def index
    @projects = []
    if @life
      @projects = @life.projects.find(:all, :include => :tasks)
    else
      @lives.each do |life|
        @projects += life.projects.find(:all, :include => :tasks)
      end
    end
    @projects.uniq!
    @projects = @projects.sort {|a,b| a.name <=> b.name}
  end
  
  def show
    user = User.find(params[:user_id]) if params[:user_id]
    if user
      @selected_user = user.id
      @tasks = @project.tasks.incomplete
      tasks_final = []
      user.lives.each do |life|
        @tasks.each do |task|
          tasks_final << task if task.lives.include? life
        end
      end
      @tasks = tasks_final
    else
      @tasks = @life.tasks
    end
     for task in @tasks
          task_log = task.task_logs.last
          if task_log && task_log.end_time.nil? then
             task_log.end_time = task_log.log_update_time + 1.minutes
             task_log.save!
             task.stop!
          end
      end

  end
  
  def new
    @project = Project.new
    @project.lives = []
    @project.lives << @life #life.profile
    render :action => :edit
  end
  
  def edit
    @profiles = []
    @current_user.lives.each do |life|
      @profiles << life.profile
    end
  end
  
  def create
    @project = Project.new(params[:project])
    @project.lives << Life.find(params[:life_id])
    @project.token = @project.generate_token
    if @project.save
      add_users
      redirect_to project_tasks_path(@project)
    else
      render :action => 'edit'
    end
  end
    
  def update
    @project.update_attributes(params[:project])
    @project.token = @project.generate_token
    if @project.save
      add_users
      redirect_to project_tasks_path(@project)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @project.destroy
    flash[:notice] = 'Goal was successfully deleted.'
    redirect_to life_projects_path @life
  end
  
  def confirm
    puts params
    @project = Project.find(:first, :conditions => {:token => params[:id]})
  end
  
  def add_to_life
    @project = Project.find(params[:id])
    @life = Life.find(params[:life][:id])
    
    @project.lives.each do |life|
      contacts = []
      @life.contacts_from.each do |contact|
        contacts << contact.contactee
      end
      unless contacts.empty? || contacts.include?(life.user)
        @contact = Contact.new
        @contact.contacter = @current_user
        @contact.contactee = life.user
        @contact.contacter_life = @life
        @contact.lives << life
        @contact.save
      end
      contacts = []
      life.contacts_from.each do |contact|
        contact.lives << @life if contact.contactee == @current_user && !contact.lives.include?(@life)
        contacts << contact.contactee
      end
      unless contacts.include? @current_user
        @contact = Contact.new
        @contact.contacter = life.user
        @contact.contactee = @current_user
        @contact.contacter_life = life
        @contact.lives << @life
        @contact.save
      end
    end
    
    @life.contacts_from.each do |contact|
      @project.lives.each do |life|
        contact.lives << life if contact.contactee == life.user && !contact.lives.include?(life)
      end
    end
    
    @project.lives << @life if @life
    flash[:notice] = "Goal successfully added to #{@life.name}"
    redirect_to life_tasks_path(@life)
  end
  
  protected
    
    def add_users
      if params[:contact_list]
        users = []
        params[:contact_list].each do |id|
          users << User.find(id[0])
        end
        users.each {|user| user.deliver_project_add_notification!(@project)}
        users.each {|user| send_project_message(user, @project)}
      end
    end
    
    def require_owner
      unless @current_profile && @project.lives.include?(@current_profile.life)
        flash[:error] = "You must be one of the goal contacts in to access this page"
        redirect_to root_path
        return false
      end
    end
    
    def send_project_message(user, project)
      @message = Message.new
      @message.user = user
      @message.sender_id = @current_user.id
      @message.sender = @current_user.name
      @message.subject = "New Goal"
      @message.body = "#{@message.sender} has added you to a goal. <br />"+
        "Goal Name: #{project.name}"
        "To see the goal just click the link below: <br />"+
        "<a href=\"#{ url_for confirm_project_url(project.token) }\">"+
        "#{ url_for confirm_project_url(project.token) }</a> <br />"+
        "If the above URL does not work try copying and pasting it into your browser. <br />"+
        "If you continue to have problem please feel free to contact us. <br />"
      @message.save
    end
end
