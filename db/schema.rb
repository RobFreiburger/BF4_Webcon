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

ActiveRecord::Schema.define(version: 20130811201629) do

  create_table "servers", force: true do |t|
    t.text     "name"
    t.text     "description"
    t.string   "battlelog_name"
    t.string   "guid"
    t.string   "ip_address"
    t.integer  "rcon_port",      limit: 5
    t.string   "rcon_password"
    t.boolean  "allow_use",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "servers", ["name"], name: "index_servers_on_name", unique: true

  create_table "users", id: false, force: true do |t|
    t.integer  "steam_id",                   null: false
    t.boolean  "is_admin",   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["steam_id"], name: "index_users_on_steam_id", unique: true

end
