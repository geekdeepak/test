class CreateLivesProjects < ActiveRecord::Migration
  def self.up
    create_table :lives_projects, :id => false do |t|
      t.integer :project_id
      t.integer :life_id
    end
  end

  def self.down
    drop_table :lives_projects
  end
end
