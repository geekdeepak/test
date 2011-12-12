class ActivationsController < ApplicationController
  before_filter :require_no_user, :only => [:create]
  before_filter :dont_display_projects

  def create
    if @user = User.find_using_perishable_token(params[:id], 1.week)
      if !@user.active?
        if @user.activate!
          @user.deliver_activation_confirmation!
          flash[:notice] = "Your account has been activated."
          redirect_to login_url
        else
          flash[:error] = "You need to create a user first!"
          redirect_to signup_url
        end
      else
        flash[:notice] = "This user has already been activated"
        redirect_to login_url
      end
    else
      flash[:notice] = "An error has occurred."
      redirect_to login_url
    end
  end

end
