require 'icalendar'

class TasksController < ApplicationController
  before_filter :require_user
  before_filter :find_context
    
  before_filter :load_task, :only => [ :start,:logs,:pause, :show, :edit, :update, :destroy, :complete, :reopen, :move_higher, :move_lower ]
  before_filter :load_tasks, :only => [ :index ]
  
  before_filter :dont_display_projects, :only => [:new, :create, :edit, :update]

#  def logs
 #    @task_logs = @task.task_logs
 # end   

  def start
    task_log = @task.task_logs.find(:last)
    # if no running task is there

    if task_log.nil? or task_log.end_time then
    	task_log = TaskLog.new
	task_log.user_id = @current_user.id
	task_log.task_id = @task.id
        task_log.start_time = Time.now
        task_log.save!
    end

    logs = @task.task_logs
    @task_logs = logs
    @used_hours = @used_minutes = @used_seconds = 0

    for log in logs 
	hours = minutes = seconds = 0

	if log.end_time == nil then		
           end_time = Time.now
	else
           end_time = log.end_time
        end
	
	total_seconds  = (end_time - log.start_time).to_f
        hours = (total_seconds/ 3600).to_i
        minutes = ((total_seconds % 3600) / 60).to_i
	seconds = ((total_seconds % 3600) % 60).to_i

        @used_hours = @used_hours + hours.to_i
	@used_minutes = @used_minutes + minutes.to_i
	@used_seconds = @used_seconds + seconds.to_i
    end
	if @used_seconds > 59 
	   @used_minutes =  (@used_seconds / 60).to_i
	   @used_seconds =  (@used_seconds  % 60).to_i
	end
	
	if @used_minutes > 59 then
	   @used_hours   = (@used_minutes / 60).to_i
	   @used_minutes =  (@used_minutes % 60).to_i
	end
    @task.start!
  end
  
  def pause
    flash[:notice] = 'Step paused.'
    task_log = TaskLog.find_last_by_task_id(@task.id)
    if task_log then
       task_log.end_time = Time.now
       task_log.save!
    end
    @task.stop!
    redirect_to project_path(@task.project)
  end
  
  def index
    @tasks.uniq!
    respond_to do |format|
      format.html
      format.xml  { render :xml => @tasks }
      format.ics { render_calendar @tasks }
    end
  end
  
  def show
    @profiles = []
    @task.lives.each do |life|
      @profiles << life.profile 
    end
    respond_to do |format|
      format.html
      format.xml  { render :xml => @task }
      format.ics { render_calendar @task }
    end
  end
  
  def complete
    flash[:notice] = 'Step completed.'
    task_log = TaskLog.find_last_by_task_id(@task.id)
    
    # if no running task is there
    if task_log.nil? or task_log.end_time then
       task_log = TaskLog.new
       task_log.start_time = Time.now
    end
    task_log.end_time = Time.now
    task_log.save!

    @task.complete!
    redirect_to project_tasks_path(@task.project)
  end
  
  def reopen
    if @task.reopen!
      flash[:notice] = 'Step reopened.'
    end
    if @tasks then
       @tasks.uniq!
    end
    redirect_to :back
  end
  
  def today
    @tasks = []
    if @project
      tasks(@project)
    elsif @life
      @life.projects.each do |project|
        tasks(project)
      end
    else
      @current_user.lives.each do |life|
        life.projects.each do |project|
          tasks(project)
        end
      end
    end
    @tasks.uniq!
    render :action => 'index'
  end
  
  def tomorrow
    @tasks = []
    if @project
      tomorrow_tasks(@project)
    elsif @life
      @life.projects.each do |project|
        tomorrow_tasks(project)
      end
    else
      @current_user.lives.each do |life|
        life.projects.each do |project|
          tomorrow_tasks(project)
        end
      end
    end
    @tasks.uniq!
    render :action => 'index'
  end
  
  def completed
    @tasks = []
    if @project
      completed_tasks(@project)
    elsif @life
      @life.projects.each do |project|
        completed_tasks(project)
      end
    else
      @current_user.lives.each do |life|
        life.projects.each do |project|
          completed_tasks(project)
        end
      end
    end
    @tasks.uniq!
    render :action => 'index'
  end
  
  def paused
    @tasks = []
    if @project
      paused_tasks(@project)
    elsif @life
      @life.projects.each do |project|
        paused_tasks(project)
      end
    else
      @current_user.lives.each do |life|
        life.projects.each do |project|
          paused_tasks(project)
        end
      end
    end
    @tasks.uniq!
    render :action => 'index'
  end
  
  def opened
    @tasks = []
    if @project
      opened_tasks(@project)
    elsif @life
      @life.projects.each do |project|
        opened_tasks(project)
      end
    else
      @current_user.lives.each do |life|
        life.projects.each do |project|
          opened_tasks(project)
        end
      end
    end
    @tasks.uniq!
    render :action => 'index'
  end
  
  def show_user
    user = User.find(params[:user_id]) if params[:user_id]
    if user
      @selected_user = user.id
      @tasks = []
      @current_user.lives.each do |life|
        life.projects.each do |project|
          @tasks += project.tasks.incomplete
        end
      end
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
    render :action => 'index'
  end
  
  def overdue
    @tasks = []
    if @project
      overdue_tasks(@project)
    elsif @life
      @life.projects.each do |project|
        overdue_tasks(project)
      end
    else
      @current_user.lives.each do |life|
        life.projects.each do |project|
          overdue_tasks(project)
        end
      end
    end
    @tasks.uniq!
    render :action => 'index'
  end
  
  def tasks(item)
    @tasks += item.tasks.today.incomplete
    @tasks += item.tasks.nodue.incomplete
  end
  
  def tomorrow_tasks(item)
    @tasks += item.tasks.tomorrow.incomplete
  end
  
  def completed_tasks(item)
    @tasks += item.tasks.completed
  end
  
  def paused_tasks(item)
    @tasks += item.tasks.paused
  end
  
  def opened_tasks(item)
    @tasks += item.tasks.opened
  end
  
  def overdue_tasks(item)
    @tasks += item.tasks.overdue.incomplete
  end
  
  def new
    @tasks = @life.tasks.find(:all, :limit => 10, :order => "created_at DESC")
    @task = Task.new
    @task.lives = []
    @task.lives << @life #life.profile
    setup_task
  end
  
  def edit
    @profiles = []
    @project.lives.each do |life|
      @profiles << life.profile 
    end
  end
    
  def create
    @task = Task.new(params[:task])
    if params[:project_id]
      @project = Project.find(params[:project_id])
    else
      @project = Project.find(params[:task][:project_id])
    end
    @task.project = @project
    add_profiles
    t = @project.tasks
    if @task.save
      @task.position = t.last.position+1
      redirect_to project_tasks_path(@task.project)
    else
      setup_task
    end
  end
  
  def update
    @task.update_attributes(params[:task])
    if @task.save
      add_profiles
      redirect_to project_tasks_path(@task.project)
    else
      render_action "edit"
    end
  end
  
  def move_lower
    @task.move_lower
    redirect_to project_tasks_path(@task.project)
  end
  
  def move_higher
    @task.move_higher
    redirect_to project_tasks_path(@task.project)
  end
  
  private
  
    def setup_task
      @profiles = [@life.profile]
      if @project
        @project.lives.each do |life|
          @profiles << life.profile 
        end
        @profiles.uniq!
      end
      @durations = []
      for x in 1..60 do
        @durations << x if x%15 == 0
      end
      render :action => :edit
    end
    
    def load_task
      @task = Task.find(params[:id])
      find_context
      @durations = []
      for x in 1..60 do
        @durations << x if x%15 == 0
      end
      @projects = []
    end
    
    def load_tasks
      @tasks = []
      if @project
        @tasks = @project.tasks.incomplete
      elsif @life
        @life.projects.each do |project|
          @tasks += project.tasks.incomplete
        end
      else
        @current_user.lives.each do |life|
          life.projects.each do |project|
            @tasks += project.tasks.incomplete
          end
        end
      end
    end
  
    def find_context
      if @task
        @project = @task.project
      end
      @life = Life.find(params[:life_id]) if params[:life_id]
      @project = Project.find(params[:project_id]) if params[:project_id]
      if @project && !@life
        @life = @project.current_user_life(@current_user)
      end
    end
    
    def add_profiles
      old_lives = @task.lives.dup
      @task.lives.delete_all  
      profile_list = params[:profile_list]
      selected_profiles = profile_list.nil? ? [@current_profile] : profile_list.keys.collect{|id| Profile.find_by_id(id)}
      selected_profiles.each {|profile| @task.lives << profile.life}
      @task.save
      old_lives.each {|life| selected_profiles.delete life.profile }
      @current_user.lives.each {|life| selected_profiles.delete life.profile }
      selected_profiles.each {|profile| profile.deliver_task_add_notification!(@task)}
      selected_profiles.each {|profile| send_task_message(profile, @task)}
    end
    
    def render_calendar(tasks)
      @cal = Icalendar::Calendar.new
      
      tasks = tasks.to_a unless tasks.is_a?(Array)
      
      tasks.each do |task|
        event = Icalendar::Event.new
        event.start = task.due.to_date
        event.end = task.due.to_date
        event.summary = task.name
        
        @cal.add event
      end
      
      render :text => @cal.to_ical, :layout => false
    end
    
    def send_task_message(profile, task)
      @message = Message.new
      @message.user = profile.life.user
      @message.sender_id = @current_user.id
      @message.sender = @current_user.username
      @message.subject = "New Step"
      @message.body = "#{@message.sender} has added you to a step. <br />"+
        "To see the step just click the link below: <br />"+
        "<a href=\"#{ url_for task }\">#{ url_for task }</a> <br />"+
        "Name: #{ task.name } <br />"+
        "Due: #{ task.due } <br />"+
        "If the above URL does not work try copying and pasting it into your browser. <br />"+
        "If you continue to have problem please feel free to contact us. <br />"
      @message.save
    end
   

end
