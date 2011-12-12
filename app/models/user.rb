# == Schema Information
# Schema version: 20090115011714
#
# Table name: users
#
#  id                :integer(4)      not null, primary key
#  username          :string(255)
#  timezone          :string(255)
#  crypted_password  :string(255)
#  password_salt     :string(255)
#  persistence_token :string(255)
#  state             :string(255)
#  perishable_token  :string(255)     default(""), not null
#  email             :string(255)     default(""), not null
#  created_at        :datetime
#  updated_at        :datetime
#  receive_emails    :boolean(1)      default(TRUE)
#  first_name        :string(255)
#  last_name         :string(255)
#

class User < ActiveRecord::Base

  # Nuclear Launch Codes anyone?
  acts_as_authentic :crypto_provider => Authlogic::CryptoProviders::BCrypt
  
  acts_as_state_machine :initial => :unauthorised
  
  validates_presence_of :username
  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  has_many :lives
  has_many :messages
  has_many :task_logs
  
  # Contacts!
  has_many :contacts_to, :foreign_key => 'contactee_id', :class_name => 'Contact', :dependent => :destroy
  has_many :contacts_from, :foreign_key => 'contacter_id', :class_name => 'Contact', :dependent => :destroy

  named_scope :enabled, :conditions => { :state => "active" }, :order => "username ASC"
  
  state :unauthorised
  state :active
  state :banned
  
  event :ban do
    transitions :to => :banned, :from => :active
    transitions :to => :banned, :from => :unauthorised
  end
  
  event :activate do
    transitions :to => :active, :from => :unauthorised
  end
  
  def name
    self.first_name + " " + self.last_name
  end
    
  def approved?
    self.active?
  end
  
  def get_unassigned_projects
    projects = self.projects.dup
    self.lives.each do |life|
      life.projects.each do |project|
        projects.delete project
      end
    end
    projects
  end

  def has_life?
    lives.count > 0
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
  
  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end 

  def deliver_activation_confirmation!
    reset_perishable_token!
    Notifier.deliver_activation_confirmation(self)
  end

  def deliver_contact_add_notification!(contact)
    if self.receive_emails
      Notifier.deliver_contact_add_notification(self,contact)
    end
  end 

  def deliver_contact_added_notification!(contact)
    if self.receive_emails
      Notifier.deliver_contact_added_notification(self,contact)
    end
  end 

  def deliver_project_add_notification!(project)
    if self.receive_emails
      Notifier.deliver_project_add_notification(self,project)
    end
  end 
  
  def has_no_credentials?
    self.crypted_password.blank? && self.openid_identifier.blank?
  end
  
end
