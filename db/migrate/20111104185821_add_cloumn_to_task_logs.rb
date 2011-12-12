class AddCloumnToTaskLogs < ActiveRecord::Migration
   def self.up
  	 add_column :task_logs, :log_update_time, :datetime ,:default=>Time.now
  end

  def self.down
  	remove_column :task_logs, :log_update_time
  end

end
