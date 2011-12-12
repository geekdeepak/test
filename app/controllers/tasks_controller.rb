require 'icalendar'

class TasksController < ApplicationController
  before_filter :require_user
  before_filter :find_context
    
  before_filter :load_task, :only => [:start,:logs,:pause, :show, :edit, :update, :destroy, :complete, :reopen, :move_higher, :move_lower,:sync_log ]
  before_filter :load_tasks, :only => [ :index,:start]
  before_filter :load_tasks_current_user, :only => [ :index,:start]
  
  before_filter :dont_display_projects, :only => [:new, :create, :edit, :update]

    def order
        cnt = 0
        ele = Array.new
        pos = Array.new
        
        for listitem in params[:listItem] 
            item = listitem.split("a")
            ele[cnt] = item[0]
            pos[cnt] = item[1].to_i
            cnt = cnt + 1
        end
        pos = pos.sort
        
        i=0
        while i<cnt
            t = Task.find(ele[i])
            t.position = pos[i]
            t.save!
            i = i + 1
         end
         render :text=>pos.to_json
    end
    
   
    def sync_log
    	task = params['id'] ? Task.find(params[:id]) : @task
    	
    	if !task.nil? then
    	   if task.state == "in_progress"
	         task_log = task.task_logs.last

           task_log.logged_time +=  (Time.now - task_log.log_update_time) / 60 
           task_log.log_update_time = Time.now

           task_log.save!
         else
      	    render :text=>"Connection broken,job paused."            
            return

         end
	    end
	    render :text=>"Connection still maintained."
    end

  def start
      task_log = @task.task_logs.last
      if (task_log && task_log.end_time) || task_log.nil? then 
             log = TaskLog.new
             log.task_id = @task.id
             log.user_id = @current_user.id
             log.start_time = Time.now
             log.log_update_time = Time.now
             log.logged_time = 0
             log.save!
      end    
      @task_logs = @task.task_logs
      minutes = 0
      minutes = @task.task_logs.sum(:logged_time)
      if minutes >= 0 then
        @used_hours   = minutes / 60 
        @used_minutes = minutes % 60
        @used_seconds = 0
      end
      if @current_user_tasks.size > 0 then
        flash[:notice] = "Some task is already in progress!! <br/> Please Pause that task and then start this."
        redirect_to project_tasks_path(@task.project)
        return 
      end
      @task.start!
  end
  
  def pause
    flash[:notice] = 'Step paused.'
    task_log = @task.task_logs.last
    if task_log then
       task_log.end_time = Time.now
       task_log.save!
    end
    @task.stop!
    redirect_to project_tasks_path(@task.project)
  end
  
  def index
    for task in @current_user_tasks
          task_log = task.task_logs.last
          if task_log && task_log.end_time.nil? && Time.now > (task_log.log_update_time + 1.minutes) then
             task_log.end_time = task_log.log_update_time + 1.minutes
             task_log.save!
             task.stop!
          end
    end

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
    @task.position = @task.id
    if @task.save
       @task.position = @task.id
       #@task.position = t.last.position+1
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
      @current_user_tasks = []
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
      @tasks = @tasks.sort_by { |my_item| my_item[:position] }
    end
    
    def load_tasks_current_user
        @current_user.lives.each do |life|
          life.projects.each do |project|
            @current_user_tasks += project.tasks.find_all_by_state("in_progress")
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
