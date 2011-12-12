class AddPositionToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :position, :integer

=begin    
    Project.all.each do |project|
      project.tasks.incomplete.all.each_with_index do |t, i|
        t.position = i+1
        t.save! 
      end
    end
=end
  end


  def self.down
    remove_column :tasks, :position
  end
end
