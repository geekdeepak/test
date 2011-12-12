class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :user_id
      t.integer :sender_id, :default => 0
      t.string :sender
      t.string :state
      t.string :subject
      t.text :body
      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
