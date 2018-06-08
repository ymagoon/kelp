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

ActiveRecord::Schema.define(version: 2018_06_08_001729) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.integer "store_number", null: false
    t.bigint "dive_center_id", null: false
    t.bigint "training_organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dive_center_id"], name: "index_agencies_on_dive_center_id"
    t.index ["store_number"], name: "index_agencies_on_store_number"
    t.index ["training_organization_id"], name: "index_agencies_on_training_organization_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.bigint "training_organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_organization_id"], name: "index_courses_on_training_organization_id"
  end

  create_table "dc_courses", force: :cascade do |t|
    t.integer "price"
    t.string "currency"
    t.bigint "course_id"
    t.bigint "dive_center_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_dc_courses_on_course_id"
    t.index ["dive_center_id"], name: "index_dc_courses_on_dive_center_id"
  end

  create_table "dive_centers", force: :cascade do |t|
    t.string "name", null: false
    t.string "primary_phone", default: ""
    t.string "mobile_phone", default: ""
    t.string "website", default: ""
    t.string "email", default: ""
    t.string "fax", default: ""
    t.string "tripadvisor", default: ""
    t.string "fb", default: ""
    t.string "twitter", default: ""
    t.string "youtube", default: ""
    t.string "google", default: ""
    t.string "linkedin", default: ""
    t.string "blog", default: ""
    t.string "project_aware", default: ""
    t.string "dive_center_type"
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_dive_centers_on_location_id"
    t.index ["name"], name: "index_dive_centers_on_name"
  end

  create_table "load_dive_centers", force: :cascade do |t|
    t.integer "store_number", null: false
    t.decimal "lat"
    t.decimal "lng"
    t.integer "active_ind", default: 1
    t.string "dive_center_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_number"], name: "index_load_dive_centers_on_store_number"
  end

  create_table "locations", force: :cascade do |t|
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "postal_code"
    t.decimal "lat"
    t.decimal "lng"
    t.string "google_place_id"
    t.string "source", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city"], name: "index_locations_on_city"
    t.index ["country"], name: "index_locations_on_country"
  end

  create_table "training_organizations", force: :cascade do |t|
    t.string "long_name"
    t.string "short_name"
    t.string "fax"
    t.string "primary_phone"
    t.string "website"
    t.string "email"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_training_organizations_on_location_id"
    t.index ["short_name"], name: "index_training_organizations_on_short_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "agencies", "dive_centers"
  add_foreign_key "agencies", "training_organizations"
  add_foreign_key "courses", "training_organizations"
  add_foreign_key "dc_courses", "courses"
  add_foreign_key "dc_courses", "dive_centers"
  add_foreign_key "dive_centers", "locations"
  add_foreign_key "training_organizations", "locations"
end
