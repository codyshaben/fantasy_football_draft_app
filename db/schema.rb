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

ActiveRecord::Schema.define(version: 2019_08_20_224254) do

  create_table "player_data", force: :cascade do |t|
    t.string "name"
    t.integer "yards"
    t.integer "touchdowns"
    t.integer "rank"
    t.string "position"
    t.integer "comb"
    t.float "sacks"
    t.integer "intercepts"
    t.integer "fg_m"
    t.integer "fg_att"
    t.string "a_m"
    t.boolean "owned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "yards"
    t.integer "touchdowns"
    t.integer "rank"
    t.string "position"
    t.integer "comb"
    t.float "sacks"
    t.integer "intercepts"
    t.integer "fg_m"
    t.integer "fg_att"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_id"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
  end

end
