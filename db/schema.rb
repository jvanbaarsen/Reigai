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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131010154757) do

  create_table "applications", force: true do |t|
    t.string   "api_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "logs", force: true do |t|
    t.integer  "application_id"
    t.string   "log_type"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "logs", ["application_id"], name: "index_logs_on_application_id"

  create_table "subscribers", force: true do |t|
    t.integer  "user_id"
    t.integer  "application_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "application_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "full_name"
  end

end
