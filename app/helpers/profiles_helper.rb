module ProfilesHelper
  def current_profile
    unless @current_profile
      if @current_user && @project
        @current_profile = @project.profiles.find_by_user_id(@current_user)
      end
    end
    @current_profile
  end
end
