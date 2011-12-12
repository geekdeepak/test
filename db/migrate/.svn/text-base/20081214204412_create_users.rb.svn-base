class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :timezone
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :state
      t.string :perishable_token, :default => "", :null => false
      t.string :email, :default => "", :null => false
      t.boolean :receive_emails, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
