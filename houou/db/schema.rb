# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_06_23_104945) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "access_tokens", force: :cascade do |t|
    t.string "token"
    t.string "auth_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "administrator_id"
    t.index ["administrator_id"], name: "index_access_tokens_on_administrator_id"
    t.index ["auth_token"], name: "index_access_tokens_on_auth_token", unique: true
    t.index ["token"], name: "index_access_tokens_on_token", unique: true
  end

  create_table "administrators", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "userid"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mahjong_games", force: :cascade do |t|
    t.uuid "east_id", null: false
    t.uuid "south_id", null: false
    t.uuid "west_id", null: false
    t.uuid "north_id"
    t.integer "east_score", null: false
    t.integer "south_score", null: false
    t.integer "west_score", null: false
    t.integer "north_score"
    t.bigint "mahjong_match_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["east_id"], name: "index_mahjong_games_on_east_id"
    t.index ["mahjong_match_id"], name: "index_mahjong_games_on_mahjong_match_id"
    t.index ["north_id"], name: "index_mahjong_games_on_north_id"
    t.index ["south_id"], name: "index_mahjong_games_on_south_id"
    t.index ["west_id"], name: "index_mahjong_games_on_west_id"
  end

  create_table "mahjong_jansous", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "google_map_url"
    t.string "address"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mahjong_matches", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "mahjong_jansou_id", null: false
    t.index ["mahjong_jansou_id"], name: "index_mahjong_matches_on_mahjong_jansou_id"
  end

  create_table "members", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "discord_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "mahjong_games", "mahjong_matches"
  add_foreign_key "mahjong_games", "members", column: "east_id"
  add_foreign_key "mahjong_games", "members", column: "north_id"
  add_foreign_key "mahjong_games", "members", column: "south_id"
  add_foreign_key "mahjong_games", "members", column: "west_id"
  add_foreign_key "mahjong_matches", "mahjong_jansous"
end
