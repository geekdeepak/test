# == Schema Information
# Schema version: 20090115011714
#
# Table name: lives
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Life < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :tasks
  has_one :profile
  
  # Contacts!
  has_many :contacts_to, :foreign_key => 'contactee_life_id', :class_name => 'Contact'
  has_many :contacts_from, :foreign_key => 'contacter_life_id', :class_name => 'Contact', :dependent => :destroy
  
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => 'user_id'
  
end
