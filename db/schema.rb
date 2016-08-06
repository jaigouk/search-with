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

ActiveRecord::Schema.define(version: 20160806210324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "btree_gin"
  enable_extension "pg_trgm"

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
    t.index ["about"], name: "index_activities_on_about", using: :gin
    t.index ["camp"], name: "index_activities_on_camp", using: :btree
    t.index ["date_night"], name: "index_activities_on_date_night", using: :btree
    t.index ["drop_in"], name: "index_activities_on_drop_in", using: :btree
    t.index ["end_months_old"], name: "index_activities_on_end_months_old", using: :btree
    t.index ["indoor"], name: "index_activities_on_indoor", using: :btree
    t.index ["outdoor"], name: "index_activities_on_outdoor", using: :btree
    t.index ["start_months_old"], name: "index_activities_on_start_months_old", using: :btree
    t.index ["title"], name: "index_activities_on_title", using: :gin
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
    t.index ["city"], name: "index_locations_on_city", using: :gin
    t.index ["name"], name: "index_locations_on_name", using: :gin
  end

  create_table "tags", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_tags_on_title", using: :gin
  end


  create_view :materilized_search_results,  sql_definition: <<-SQL
      SELECT activities.id AS searchable_id,
      'Activity'::character varying AS searchable_type,
      activities.title AS searchable_title,
      activities.about AS searchable_about,
      activities.camp AS searchable_camp,
      activities.indoor AS searchable_indoor,
      activities.outdoor AS searchable_outdoor,
      activities.drop_in AS searchable_drop_in,
      activities.date_night AS searchable_date_night,
      ((activities.title)::text || activities.about) AS the_text
     FROM activities;
  SQL

end
