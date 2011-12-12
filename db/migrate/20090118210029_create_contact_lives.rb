class CreateContactLives < ActiveRecord::Migration
  def self.up
    create_table :contacts_lives, :id => false do |t|
      t.integer :contact_id
      t.integer :life_id
    end
    Contact.all.each do |contact|
      if contact.contactee_life_id
        life = Life.find(contact.contactee_life_id)
        contact.lives << life
      end
    end
    remove_column :contacts, :contactee_life_id
  end
 
  def self.down
    add_column :contacts, :contactee_life_id, :integer
    drop_table :contacts_lives
  end
end
