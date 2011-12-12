# == Schema Information
# Schema version: 20090115011714
#
# Table name: projects
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :string(255)
#  state       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  token       :integer(4)
#

class Project < ActiveRecord::Base

  has_and_belongs_to_many :lives
  has_many :tasks, :dependent => :destroy, :order => "position"
  
  validates_presence_of :name
  
  def hours_complete
    sum = 0
    self.tasks.completed.each do |task|
      sum += task.duration || 0
    end
    sum
  end
  
  def hours
    sum = 0
    self.tasks.each do |task|
      sum += task.duration || 0
    end
    sum
  end
  
  def completion
    #result = self.hours_complete.to_f / self.hours.to_f
    result = self.tasks.completed.count.to_f / self.tasks.count.to_f
    result.nan? ? 0 : result
  end
  
  def next_task(profile)
    tasks = []
    for task in self.tasks.incomplete.hasdue
      tasks << task if task.profiles.include? profile
    end
    tasks.count > 0 ? tasks.first : nil
  end
  
  def current_user_life(current_user)
    self.lives.find_by_user_id(current_user.id)
  end
  
  def token
    the_token = read_attribute(:token)
    write_attribute(:token, generate_token) if the_token.blank?
    read_attribute(:token)
  end
  
  def generate_token
    (self.name.to_s + self.created_at.to_s).hash
  end
end