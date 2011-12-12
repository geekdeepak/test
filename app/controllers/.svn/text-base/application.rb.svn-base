# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include HoptoadNotifier::Catcher
  require 'digest/md5'
  protect_from_forgery
  helper :all
  layout 'master'
  before_filter :authenticate
  before_filter :timezone_manager
  before_filter :display_projects
  before_filter :get_lives
  before_filter :get_projects
  before_filter :get_users
  before_filter :current_profile
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user
  
  # simple error handling when in production environment
  #if RAILS_ENV == 'production'
  #  rescue_from ActionController::UnknownAction, :with => :not_found
  #  rescue_from NoMethodError, :with => :not_found
  #  rescue_from NameError, :with => :not_found
  #  rescue_from ActionView::MissingTemplate, :with => :not_found
  #end
  
  private
    
    def get_lives
      if @current_user
        @lives = @current_user.lives
        @life = Life.find(params[:life_id]) if params[:life_id]
        @life = Life.find(params[:id]) if params[:id] && params[:controller] == "lives"
      end
    end
    
    def get_projects
      if @current_user
        @project = Project.find(params[:id]) if params[:id] && params[:controller] == "projects" && params[:action] != "confirm"
        @project = Project.find(params[:project_id]) if params[:project_id]
        
        if @project
          @project.lives.each do |life|
            @life = life if life.user == @current_user
          end
        end
        
        @projects = []
        if @life
          @projects = @life.projects
        else
          @lives.each do |life|
            @projects += life.projects
          end
        end
        @projects.uniq!
        @projects = @projects.sort {|a,b| a.name <=> b.name}
      end
    end
    
    def get_users
      if @current_user
        @users = []
        @users << @current_user
        if @project
          @project.lives.each do |life|
            @users << life.user
          end
        elsif @life
          @life.projects.each do |project|
            project.lives.each do |life|
              @users << life.user
            end
          end
        elsif @task
          @task.project.lives.each do |life|
            @users << life.user
          end
        else
          @lives.each do |life|
            life.projects.each do |project|
              project.lives.each do |life|
                @users << life.user
              end
            end
          end
        end
        @users = @users.uniq! || @users
        @users.sort {|a,b| a.name <=> b.name}
      end
    end
    
    def current_profile
      if @current_user && @life
        @current_profile = @life.profile
      end
    end

    def login_required
      require_user
    end
    
    def timezone_manager 
      Time.zone = current_user.timezone if current_user && current_user.timezone 
   	end 
   	
   	def display_projects
   	  @display_projects = true
   	end
   	
   	def dont_display_projects
   	  @display_projects = false
   	end
 	
    def require_user
      unless current_user
        store_location
        flash[:error] = "You must be logged in to access this page"
        redirect_to login_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:error] = "You must be logged out to access this page"
        redirect_to root_path
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def not_found
      flash[:error] = "Page not found"
      unless current_user
        redirect_to login_url
      else
        redirect_to root_url
      end
    end

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == "rocketboys" && Digest::MD5.hexdigest(password) == 'b4d8faa3f0a8e4b0fe4691360396d89b'
      end
    end
end
