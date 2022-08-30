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

ActiveRecord::Schema[7.0].define(version: 2022_08_30_123921) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_areas_on_user_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.bigint "teacher_id", null: false
    t.date "date"
    t.integer "progress"
    t.text "teacher_message"
    t.text "area_message"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_assignments_on_school_id"
    t.index ["teacher_id"], name: "index_assignments_on_teacher_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "classes_number"
    t.bigint "area_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["area_id"], name: "index_schools_on_area_id"
    t.index ["user_id"], name: "index_schools_on_user_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.bigint "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_teachers_on_school_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "areas", "users"
  add_foreign_key "assignments", "schools"
  add_foreign_key "assignments", "teachers"
  add_foreign_key "schools", "areas"
  add_foreign_key "schools", "users"
  add_foreign_key "teachers", "schools"
end
