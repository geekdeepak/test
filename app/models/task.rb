# == Schema Information
# Schema version: 20090115011714
#
# Table name: tasks
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  due         :datetime
#  description :string(255)
#  duration    :integer(4)
#  state       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  project_id  :integer(4)
#

class Task < ActiveRecord::Base

  acts_as_state_machine :initial => :open
  acts_as_list :scope => :project
  
  has_and_belongs_to_many :lives
  belongs_to :project

  has_many   :task_logs
	  
  validates_presence_of :name
  
  validates_presence_of :project
  named_scope :overdue, :conditions => {:due => Time.now.utc-2.days..Time.current }, :order => "due ASC"
  named_scope :nodue, :conditions => { :due => nil }
  named_scope :hasdue, :conditions => ["due != ''"], :order => "due ASC"
  named_scope :incomplete, :conditions => ["state != 'closed'"]
  named_scope :completed, :conditions => { :state => "closed" }
  named_scope :paused, :conditions => { :state => "paused" }
  named_scope :opened, :conditions => { :state => "open" }
  named_scope :today, :conditions => { :due => Time.now.utc..Time.now.utc+1.day}, :order => "due ASC"
  named_scope :tomorrow, :conditions => {:due => Time.now.utc+1.day..Time.now.utc+2.days}, :order => "due ASC"
  
  state :open
  state :closed
  state :in_progress
  state :paused

  event :complete do
    transitions :to => :closed, :from => :open
    transitions :to => :closed, :from => :in_progress
    transitions :to => :closed, :from => :paused
  end

  event :reopen do
    transitions :to => :open, :from => :closed
  end

  event :start do
    transitions :to => :in_progress, :from => :open
    transitions :to => :in_progress, :from => :paused
  end

  event :stop do
    transitions :to => :paused, :from => :in_progress
  end
  
  def completed?
    self.closed?
  end
  

  def postpone!(time)
    case time
      when /^(\d+)\s?m+/ then duetime = self.due + $1.to_i.minutes
      when /^(\d+)\s?h+/ then duetime = self.due + $1.to_i.hours
      when /^(\d+)\s?d+/ then duetime = self.due + $1.to_i.days
    end
    update_attribute(:due, duetime)
  end
  
  def overdue?
    if self.due
      self.due < Time.current && !self.completed?
    else
      false
    end
  end
  
  def today?
    self.due.to_date == Date.current
  end
  
  def conflict?
    #return self.conflicts.count > 0
    false
  end
    
  def conflicts
    if self.due
      @conflicts = self.user.tasks.find(:all, :conditions => {:due => self.due})
      @conflicts.delete self
    end
    @conflicts || []
  end
  
  def due_date_time
    if self.due
      if self.today?
        self.due.strftime("%l:%M%p").downcase!
      else
        self.due.to_datetime.strftime("%x<br/>%X")
      end
    else
      "&nbsp;"
    end
  end
  
  def after_initialize
    set_initial_state if self.new_record?
    set_initial_state if self.state.nil?
  end
  
  def users
    users = []
    self.lives.each do |life|
      users << life.user
    end
    users
  end
end
