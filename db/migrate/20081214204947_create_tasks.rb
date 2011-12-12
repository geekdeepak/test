class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.datetime :due
      t.string :description
      t.integer :duration
      t.string :state
      t.integer :project_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
