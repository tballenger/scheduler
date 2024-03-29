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

ActiveRecord::Schema.define(version: 20140208033316) do

  create_table "contacts", force: true do |t|
    t.string   "name",          null: false
    t.string   "first_name",    null: false
    t.string   "last_name",     null: false
    t.string   "email_address"
    t.string   "phone_number"
    t.string   "xero_uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title",       null: false
    t.datetime "starts_at",   null: false
    t.datetime "ends_at",     null: false
    t.boolean  "all_day"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "service_id"
    t.integer  "user_id"
  end

  create_table "services", force: true do |t|
    t.string   "name",             null: false
    t.text     "description"
    t.decimal  "price",            null: false
    t.integer  "minutes_duration", null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_slots", force: true do |t|
    t.datetime "starts_at",                  null: false
    t.datetime "ends_at",                    null: false
    t.integer  "event_id",                   null: false
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "billed",     default: false
    t.string   "token"
    t.decimal  "price"
  end

  create_table "users", force: true do |t|
    t.string   "name",                   default: ""
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "business_name"
    t.text     "business_description"
    t.string   "business_address"
    t.string   "business_phone"
    t.string   "business_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
