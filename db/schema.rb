# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111108023654) do

  create_table "contacts", :force => true do |t|
    t.integer  "contacter_id"
    t.integer  "contactee_id"
    t.integer  "contacter_life_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts_lives", :id => false, :force => true do |t|
    t.integer "contact_id"
    t.integer "life_id"
  end

  create_table "lives", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lives_projects", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "life_id"
  end

  create_table "lives_tasks", :id => false, :force => true do |t|
    t.integer "life_id"
    t.integer "task_id"
  end

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "sender_id",  :default => 0
    t.string   "sender"
    t.string   "state"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifiers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "life_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "address_3"
    t.string   "city"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles_projects", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "profile_id"
  end

  create_table "profiles_tasks", :id => false, :force => true do |t|
    t.integer "task_id"
    t.integer "profile_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "state"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_logs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "task_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "logged_time"
    t.datetime "log_update_time", :default => '2011-11-08 09:49:54'
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.datetime "due"
    t.text     "description"
    t.integer  "duration"
    t.string   "state"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "timezone"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "state"
    t.string   "perishable_token",  :default => "",   :null => false
    t.string   "email",             :default => "",   :null => false
    t.boolean  "receive_emails",    :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
  end

end
