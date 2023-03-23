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

ActiveRecord::Schema[7.0].define(version: 2023_03_23_105625) do
  create_table "departments", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_departments_on_employer_id"
  end

  create_table "employees", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_employees_on_employer_id"
  end

  create_table "employerbanks", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_employerbanks_on_employer_id"
  end

  create_table "employerdetails", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_employerdetails_on_employer_id"
  end

  create_table "employerfinancials", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_employerfinancials_on_employer_id"
  end

  create_table "employerlocations", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.string "country"
    t.string "county"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_employerlocations_on_employer_id"
  end

  create_table "employers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "departments", "employers"
  add_foreign_key "employees", "employers"
  add_foreign_key "employerbanks", "employers"
  add_foreign_key "employerdetails", "employers"
  add_foreign_key "employerfinancials", "employers"
  add_foreign_key "employerlocations", "employers"
end
