class Notifier < ActionMailer::Base

  default_url_options[:host] = SITE_DOMAIN
  
  # Emails to Users

  def password_reset_instructions(user)
    setup_user_email(user)
    @subject += "Password Reset Instructions"
    @body[:reset_url] = reset_url(user.perishable_token)
  end
  
  def activation_instructions(user)
    setup_user_email(user)
    @subject += "Activation Instructions"
    @body[:account_activation_url] = activate_url(user.perishable_token)
  end

  def activation_confirmation(user)
    setup_user_email(user)
    @subject += "Activation Complete"
    @body[:root_url] = root_url
  end

  def contact_add_notification(user,contact)
    setup_user_email(user)
    @subject += "New Contact Request"
    @body[:contact_url] = contacts_url
    @body[:contacter] = contact.contacter
  end

  def new_message(message)
    setup_user_email(message.user)
    @subject += "New Message: " + message.subject
    @body[:message_url] = message_url(message.id)
    @body[:message] = message
  end

  def project_add_notification(profile,project)
    setup_profile_email(profile)
    @subject += "New Goal"
    @body[:project_url] = confirm_project_url(project.token)
    @body[:project] = project
  end
  
  # Emails to Profiles

  def task_add_notification(profile,task)
    setup_profile_email(profile)
    @subject += "New Step"
    @body[:task_url] = task_url(task.id)
    @body[:task] = task
  end

  def task_update_notification(profile,task)
    setup_profile_email(profile)
    @subject += "Updated Step"
    @body[:task_url] = task_url(task.id)
    @body[:task] = task
  end
  
  private
  
    def setup_user_email(user)
      @recipients  = "#{user.email}"
      @from        = "#{SITE_NAME} <noreply@#{SITE_DOMAIN}>"
      @subject     = "[#{SITE_NAME}] "
      @sent_on     = Time.now
      @body[:user_name] = user.username
    end
  
    def setup_profile_email(profile)
      @recipients  = "#{profile.email}"
      @from        = "#{SITE_NAME} <noreply@#{SITE_DOMAIN}>"
      @subject     = "[#{SITE_NAME}] "
      @sent_on     = Time.now
      @body[:user_name] = profile.name
    end

end
