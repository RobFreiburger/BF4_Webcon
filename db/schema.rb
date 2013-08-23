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

ActiveRecord::Schema.define(version: 20130822233649) do

  create_table "players", force: true do |t|
    t.string   "guid",       limit: 32
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["guid"], name: "index_players_on_guid", unique: true
  add_index "players", ["name"], name: "index_players_on_name", unique: true

  create_table "users", id: false, force: true do |t|
    t.decimal  "steam_id",           precision: 20, scale: 0,                 null: false
    t.boolean  "is_admin",                                    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.boolean  "is_verified",                                 default: false
    t.string   "verification_token"
    t.integer  "profile_id"
    t.integer  "player_id"
  end

  add_index "users", ["player_id"], name: "index_users_on_player_id", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"
  add_index "users", ["steam_id"], name: "index_users_on_steam_id", unique: true

end
