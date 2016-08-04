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

ActiveRecord::Schema.define(version: 20160804150752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "title"
    t.text     "about"
    t.integer  "price"
    t.integer  "start_months_old"
    t.integer  "end_months_old"
    t.boolean  "camp"
    t.boolean  "drop_in"
    t.boolean  "date_night"
    t.boolean  "indoor"
    t.boolean  "outdoor"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "activity_locations", force: :cascade do |t|
    t.integer  "activity_id"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["activity_id"], name: "index_activity_locations_on_activity_id", using: :btree
    t.index ["location_id"], name: "index_activity_locations_on_location_id", using: :btree
  end

  create_table "activity_tags", force: :cascade do |t|
    t.integer  "activity_id"
    t.integer  "tag_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["activity_id"], name: "index_activity_tags_on_activity_id", using: :btree
    t.index ["tag_id"], name: "index_activity_tags_on_tag_id", using: :btree
  end

  create_table "ar_internal_metadata", primary_key: "key", id: :string, force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "line1"
    t.string   "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
