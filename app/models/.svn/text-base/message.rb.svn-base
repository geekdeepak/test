# == Schema Information
# Schema version: 20090115011714
#
# Table name: messages
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  sender_id  :integer(4)      default(0)
#  sender     :string(255)
#  state      :string(255)
#  subject    :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class Message < ActiveRecord::Base

  named_scope :unopened, :conditions => {:state => "unread" }, :order => "created_at DESC"

  belongs_to :user
  
  validates_presence_of :subject
  validates_presence_of :body

  acts_as_state_machine :initial => :unread

  state :unread
  state :read
  
  event :mark_read do
    transitions :to => :read, :from => :unread
  end
  
  event :mark_unread do
    transitions :to => :unread, :from => :read
  end
  
  def deliver!
    if self.user.receive_emails
      Notifier.deliver_new_message(self)
    end
  end

end
