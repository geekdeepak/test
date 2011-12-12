# == Schema Information
# Schema version: 20090115011714
#
# Table name: profiles
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  first_name :string(255)
#  last_name  :string(255)
#  address_1  :string(255)
#  address_2  :string(255)
#  address_3  :string(255)
#  city       :string(255)
#  phone      :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  life_id    :integer(4)
#

class Profile < ActiveRecord::Base
  belongs_to :life
  
  def name
    the_name = self.first_name || ""
    the_name += " "
    the_name += self.last_name || ""
    the_name.blank? ? self.life.user.name : the_name
  end
  
  def email
    mail = read_attribute(:email)
    mail.nil? || mail.blank? ? self.life.user.email : mail
  end
  
  def address
    address = []
    address << self.address_1 unless self.address_1.blank?
    address << self.address_2 unless self.address_2.blank?
    address << self.address_3 unless self.address_3.blank?
    address << self.city unless self.city.blank?
    address.map().join(',<br />')
  end

  def deliver_task_add_notification!(task)
    if self.life.user.receive_emails
      Notifier.deliver_task_add_notification(self,task)
    end
  end 

  def deliver_task_update_notification!(task)
    if self.life.user.receive_emails
      Notifier.deliver_task_update_notification(self,task)
    end
  end 
end
