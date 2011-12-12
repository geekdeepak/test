class LivesController < ApplicationController

  before_filter :require_user
  
  def index
  end
  
  def show
    user = User.find(params[:user_id]) if params[:user_id]
    if user
      @selected_user = user.id
      @tasks = @life.tasks.incomplete
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
  end
  
  def new
    @life = Life.new
    render :action => :edit
  end
  
  def create
    @life = Life.new(params[:life])
    @life.user = @current_user
    if @life.save
      create_profile
      redirect_to edit_profile_path(@life.profile)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    load_life
    @life.destroy
    flash[:notice] = 'Life was successfully deleted.'
    redirect_to tasks_path
  end
  
  def today
    @tasks = []
    if @life
      @life.projects.each do |project|
        @tasks += project.tasks.incomplete.today
      end
      render :action => 'show'
    else
      load_lives
      @lives.each do |life|
        life.projects.each do |project|
          @tasks += project.tasks.incomplete.today
        end
      end
      @tasks.sort {|a,b| a.due <=> b.due}
      render :action => 'index'
    end
  end
  
  def tomorrow
    load_life
    @tasks = []
    if @life
      @life.projects.each do |project|
        @tasks += project.tasks.incomplete.tomorrow
      end
      render :action => 'show'
    else
      load_lives
      @lives.each do |life|
        life.projects.each do |project|
          @tasks += project.tasks.incomplete.tomorrow
        end
      end
      @tasks.sort {|a,b| a.due <=> b.due}
      render :action => 'index'
    end
  end
  
  def completed
    load_life
    @tasks = []
    if @life
      @life.projects.each do |project|
        @tasks += project.tasks.completed
      end
      render :action => 'show'
    else
      load_lives
      @lives.each do |life|
        life.projects.each do |project|
          @tasks += project.tasks.completed
        end
      end
      @tasks.sort {|a,b| a.due <=> b.due}
      render :action => 'index'
    end
  end
  
  def overdue
    load_life
    @tasks = []
    if @life
      @life.projects.each do |project|
        @tasks += project.tasks.overdue.incomplete
      end
      render :action => 'show'
    else
      load_lives
      @lives.each do |life|
        life.projects.each do |project|
          @tasks += project.tasks.overdue.incomplete
        end
      end
      @tasks.sort {|a,b| a.due <=> b.due}
      render :action => 'index'
    end
  end
    
  def update
    @life.update_attributes(params[:life])
    if @life.save
      redirect_to life_tasks_path(@life)
    else
      render :action => 'edit'
    end
  end
  
  def edit
    load_life
  end
  
  protected
    def load_life
      @life = Life.find(params[:id]) if params[:id]
    end
  
    def create_profile
      @profile = Profile.new
      @profile.save
      @life.profile = @profile
    end
    
    def load_life_tasks
      due_tasks = []
      undue_tasks = []
      @life.projects.each do |project|
        due_tasks += project.tasks.incomplete.hasdue
        undue_tasks += project.tasks.incomplete.nodue
      end
      @tasks = due_tasks.sort {|a,b| a.due <=> b.due}
      @tasks += undue_tasks
    end
    
    def get_profiles
      @profiles = []
      if @life
        @life.projects.each do |project|
          project.lives.each do |life|
            @profiles << life.profile
          end
        end
      elsif @lives
        @lives.each do |life|
          life.projects.each do |project|
            project.lives.each do |life|
              @profiles << life.profile
            end
          end
        end
      end
      @profiles.uniq!
      @profiles.sort {|a,b| a.name <=> b.name}
    end
end
