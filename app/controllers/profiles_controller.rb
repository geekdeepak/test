class ProfilesController < ApplicationController
  before_filter :dont_display_projects
  
  def index
    @lives = @current_user.lives.find(:all, :include => :profile)
  end
  
  def new
    @profile = Profile.new
    render :action => :edit
  end
  
  def show
    if @life
      @profile = @life.profile
    else
      @profile = Profile.find(params[:id])
    end
  end
  
  def edit
    @profile = Profile.find(params[:id])
    @life = @profile.life
  end
  
  def create
    @profile = Profile.new(params[:profile])
    @profile.user = @current_user
    if @profile.save
      redirect_to @profile
    end
  end
    
  def update
    @profile = Profile.find(params[:id])
    @profile.update_attributes(params[:profile])
    redirect_to @profile
  end
  
  def destroy
    @project.destroy
    flash[:success] = 'Project was successfully deleted.'
    redirect_to @life
  end
end
