class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.integer :contacter_id
      t.integer :contactee_id
      t.integer :contacter_life_id
      t.integer :contactee_life_id
      t.string :token
      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
