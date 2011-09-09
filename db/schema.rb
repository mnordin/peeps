# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110909071354) do

  create_table "locales", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "offices", :force => true do |t|
    t.string   "name"
    t.integer  "locale_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "scores", :force => true do |t|
    t.integer  "correct_peeps"
    t.integer  "duration"
    t.integer  "user_id"
    t.integer  "office_id",       :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "incorrect_peeps"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "photo_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number_of_logins",          :default => 0
    t.integer  "number_of_completed_games", :default => 0
    t.datetime "last_logged_in"
    t.integer  "office_id"
    t.string   "fb_access_token"
  end

end
