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

ActiveRecord::Schema.define(version: 2019_06_03_224828) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.hstore "classifications", default: {}
    t.text "images", default: [], array: true
    t.boolean "suggested", default: false
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "venue_event_id"
    t.integer "rating"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
    t.index ["venue_event_id"], name: "index_reviews_on_venue_event_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "venue_event_id"
    t.boolean "bought", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tickets_on_user_id"
    t.index ["venue_event_id"], name: "index_tickets_on_venue_event_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "avatar"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "venue_events", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "venue_id"
    t.boolean "on_sale"
    t.hstore "sale_info", default: {}
    t.hstore "pricing_info", default: {}
    t.hstore "event_info", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_venue_events_on_event_id"
    t.index ["venue_id"], name: "index_venue_events_on_venue_id"
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.hstore "address_info", default: {"latitude"=>nil, "longitude"=>nil}
    t.hstore "box_office_info", default: {}
    t.text "images", default: [], array: true
    t.boolean "suggested", default: false
  end

  add_foreign_key "reviews", "users"
  add_foreign_key "reviews", "venue_events"
  add_foreign_key "tickets", "users"
  add_foreign_key "tickets", "venue_events"
  add_foreign_key "venue_events", "events"
  add_foreign_key "venue_events", "venues"
end
