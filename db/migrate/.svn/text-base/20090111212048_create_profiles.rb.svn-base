class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :life_id
      t.string :first_name
      t.string :last_name
      t.string :address_1
      t.string :address_2
      t.string :address_3
      t.string :city
      t.string :phone
      t.string :email
      t.timestamps
    end
    create_table :profiles_projects, :id => false do |t|
      t.integer :project_id
      t.integer :profile_id
    end
    create_table :profiles_tasks, :id => false do |t|
      t.integer :task_id
      t.integer :profile_id
    end
    User.all.each do |user|
      profile = Profile.new
      user.profiles << profile
    end
  end

  def self.down
    drop_table :profiles
    drop_table :profiles_projects
    drop_table :profiles_tasks
  end
end
