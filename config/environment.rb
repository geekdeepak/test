# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
ENV['RAILS_ENV'] ||= 'production'

ENV['GEM_PATH'] = '/home/webtoday/.gems/'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.gem "authlogic"
  config.gem "bcrypt-ruby", :lib => "bcrypt"
  config.gem "calendar_date_select"
  config.gem "icalendar"

  config.action_controller.session = {
    :session_key => '_lifemasher_session',
    :secret      => '1df3fce4beeecf291eef6474730d6bbd99bba282e6d25bcadff498cbe7a7106be13be3fba9b9c1474b0961a5ede0b04a712cd6d7cc6e17da5d303a4a6216c9aa'
  }
  
  #config.action_controller.session_store = :active_record_store

end
