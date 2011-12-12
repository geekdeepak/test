class UsersController < ApplicationController
  
  before_filter :require_no_user, :only => [ :new, :create ]
  
  before_filter :load_user, :only => [ :show, :edit, :update, :destroy ]
  
  before_filter :require_owner, :except => [ :new, :create, :index ]
  
  before_filter :dont_display_projects
  
  def new
    @user = User.new
    render :action => :edit
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save_without_session_maintenance
      @user.deliver_activation_instructions!
      flash[:notice] = "Your account has been created.<br />Please check your e-mail for activation instructions!"
      redirect_to login_url
    else
      render :action => :edit
    end
  end
  
  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_path(@user)
    else
      render :action => :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:notice] = "User has been deleted."
    redirect_to login_path
  end

  private
    
    def load_user
      @user = User.find(params[:id])
    end
    
    def require_owner
      unless @current_user && @user && @user.id == @current_user.id
        flash[:error] = "Settings are only accessible by the owner"
        redirect_to root_path
        return false
      end
    end
    
    def require_owner_or_contact
      unless @user.contacts.include?(@current_user)
        require_owner
      end
    end
end
