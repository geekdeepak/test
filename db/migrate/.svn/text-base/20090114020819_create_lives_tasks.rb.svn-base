class CreateLivesTasks < ActiveRecord::Migration
  def self.up
    create_table :lives_tasks, :id => false do |t|
      t.integer :life_id
      t.integer :task_id
    end
  end

  def self.down
    drop_table :lives_tasks
  end
end
