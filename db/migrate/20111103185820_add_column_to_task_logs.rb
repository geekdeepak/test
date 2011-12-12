class AddColumnToTaskLogs < ActiveRecord::Migration
  def self.up
  	 add_column :task_logs, :logged_time, :integer
  end

  def self.down
  	remove_column :task_logs, :logged_time
  end
end
