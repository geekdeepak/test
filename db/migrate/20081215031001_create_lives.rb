class CreateLives < ActiveRecord::Migration
  def self.up
    create_table :lives do |t|
      t.integer :user_id
      t.string :name
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :lives
  end
end
