class CreateTaskLogs < ActiveRecord::Migration
  def self.up
    create_table :task_logs do |t|
      t.integer           :user_id           
      t.integer           :project_id        
      t.integer           :task_id
      t.timestamp         :start_time
      t.timestamp         :end_time        
      t.timestamps
    end
  end

  def self.down
    drop_table :task_logs
  end
end
