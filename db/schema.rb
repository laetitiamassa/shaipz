# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120707164718) do

  create_table "participations", :force => true do |t|
    t.integer  "participant_id", :null => false
    t.integer  "project_id",     :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "projects", :force => true do |t|
    t.integer  "owner_id",                                :null => false
    t.string   "name",                                    :null => false
    t.string   "address"
    t.integer  "total_amount",                            :null => false
    t.integer  "total_space",                             :null => false
    t.integer  "maximum_shaipz",                          :null => false
    t.string   "source_link"
    t.boolean  "cohousing",            :default => false
    t.text     "event"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "zipcode",              :default => 0,     :null => false
    t.string   "city"
  end

  create_table "reports", :force => true do |t|
    t.integer  "reportable_id",   :null => false
    t.string   "reportable_type", :null => false
    t.text     "content",         :null => false
    t.integer  "reporter_id",     :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "reports", ["reportable_id", "reportable_type"], :name => "index_reports_on_reportable_id_and_reportable_type"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "favorite_areas",         :default => "",    :null => false
    t.integer  "maximum_budget"
    t.integer  "minimum_space",          :default => 0,     :null => false
    t.boolean  "cohousing",              :default => false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "name"
    t.string   "personal_status"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
