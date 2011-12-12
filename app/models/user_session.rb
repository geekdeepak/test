class UserSession < Authlogic::Session::Base
  # various configuration goes here, see AuthLogic::Session::Config for more details
  
  # change the login field
  # set default remember me on login screen
  login_field = :username
  remember_me = true
  
  # Change default messages
  login_not_found_message = "The username or password that you entered is incorrect"
  password_invalid_message = "The username or password that you entered is incorrect"
  not_approved_message = "Your account has been banned."
  not_active_message = "Your account has not yet been activated."
  
end
