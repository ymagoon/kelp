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

ActiveRecord::Schema.define(version: 2018_06_14_105729) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.integer "store_number", null: false
    t.bigint "dive_center_id", null: false
    t.bigint "training_organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dive_center_id"], name: "index_agencies_on_dive_center_id"
    t.index ["store_number", "training_organization_id"], name: "index_agencies_on_store_number_and_training_organization_id", unique: true
    t.index ["store_number"], name: "index_agencies_on_store_number"
    t.index ["training_organization_id"], name: "index_agencies_on_training_organization_id"
  end

  create_table "agency_twos", force: :cascade do |t|
    t.integer "store_number", null: false
    t.bigint "dc_two_id", null: false
    t.bigint "training_organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dc_two_id"], name: "index_agency_twos_on_dc_two_id"
    t.index ["training_organization_id"], name: "index_agency_twos_on_training_organization_id"
  end

  create_table "answers", force: :cascade do |t|
    t.string "answer", null: false
    t.bigint "question_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
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

  create_table "dc_twos", force: :cascade do |t|
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
    t.index ["location_id"], name: "index_dc_twos_on_location_id"
    t.index ["name"], name: "index_dc_twos_on_name"
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
    t.string "hours_of_operation"
    t.boolean "rent_equipment", default: false
    t.boolean "rent_camera"
    t.boolean "nitrox", default: false
    t.boolean "rent_computer", default: false
    t.boolean "lodging", default: false
    t.boolean "restaurant", default: false
    t.boolean "bar", default: false
    t.boolean "transfers", default: false
    t.boolean "pool", default: false
    t.integer "verified"
    t.string "ig"
    t.string "pinterest"
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

  create_table "questions", force: :cascade do |t|
    t.string "question", null: false
    t.bigint "user_id"
    t.bigint "dive_center_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dive_center_id"], name: "index_questions_on_dive_center_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "feedback"
    t.integer "staff", null: false
    t.integer "boat", null: false
    t.integer "safety", null: false
    t.integer "facilities", null: false
    t.integer "rental_equipment", null: false
    t.integer "eco_friendly", null: false
    t.integer "logistics", null: false
    t.float "overall"
    t.bigint "dive_center_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dive_center_id"], name: "index_reviews_on_dive_center_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
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

  create_table "user_favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "dive_center_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dive_center_id"], name: "index_user_favorites_on_dive_center_id"
    t.index ["user_id"], name: "index_user_favorites_on_user_id"
  end

  create_table "user_histories", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "dive_center_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dive_center_id"], name: "index_user_histories_on_dive_center_id"
    t.index ["user_id"], name: "index_user_histories_on_user_id"
  end

  create_table "user_searches", force: :cascade do |t|
    t.bigint "user_id"
    t.string "search_string", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_searches_on_user_id"
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
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "full_name"
    t.string "username"
    t.string "phone"
    t.bigint "location_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["location_id"], name: "index_users_on_location_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "agencies", "dive_centers"
  add_foreign_key "agencies", "training_organizations"
  add_foreign_key "agency_twos", "dc_twos"
  add_foreign_key "agency_twos", "training_organizations"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "courses", "training_organizations"
  add_foreign_key "dc_courses", "courses"
  add_foreign_key "dc_courses", "dive_centers"
  add_foreign_key "dc_twos", "locations"
  add_foreign_key "dive_centers", "locations"
  add_foreign_key "questions", "dive_centers"
  add_foreign_key "questions", "users"
  add_foreign_key "reviews", "users"
  add_foreign_key "training_organizations", "locations"
  add_foreign_key "user_favorites", "dive_centers"
  add_foreign_key "user_favorites", "users"
  add_foreign_key "user_histories", "dive_centers"
  add_foreign_key "user_histories", "users"
  add_foreign_key "user_searches", "users"
  add_foreign_key "users", "locations"
end
