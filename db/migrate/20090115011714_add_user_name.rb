class AddUserName < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    User.all.each do |user|
      user.update_attribute :first_name, user.username
      user.update_attribute :last_name, ""
      user.save
      message = Message.new
      message.subject = "New Changes"
      message.body = "There have been new fields added to your user account. <br />"
      message.body += "Please access your settings page and add your First and Last names"
      message.user = user
      message.sender = "LifeMasher Admin"
      message.save
    end
  end

  def self.down
    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
