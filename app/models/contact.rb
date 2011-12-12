# == Schema Information
# Schema version: 20090115011714
#
# Table name: contacts
#
#  id                :integer(4)      not null, primary key
#  contacter_id      :integer(4)
#  contactee_id      :integer(4)
#  contacter_life_id :integer(4)
#  contactee_life_id :integer(4)
#  token             :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class Contact < ActiveRecord::Base
  belongs_to :contacter, :class_name => 'User', :foreign_key => 'contacter_id'
  belongs_to :contactee, :class_name => 'User', :foreign_key => 'contactee_id'
  belongs_to :contacter_life, :class_name => 'Life', :foreign_key => 'contacter_life_id'
  has_and_belongs_to_many :lives
  
  def token
    the_token = read_attribute(:token)
    write_attribute(:token, generate_token) unless the_token
    read_attribute(:token)
  end
  
  def generate_token
    (
      self.contactee.username +
      self.contacter.username +
      self.contacter_life.name
     ).hash
  end
  
  def profiles
    profs = []
    self.lives.find(:all, :include => :profile).each do |life|
      profs << life.profile
    end
  end
end
