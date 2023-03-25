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

ActiveRecord::Schema[7.0].define(version: 2023_03_25_224245) do
  create_table "attendances", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.datetime "date"
    t.datetime "time_in"
    t.datetime "time_out"
    t.boolean "is_present"
    t.boolean "is_late"
    t.boolean "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_attendances_on_employee_id"
  end

  create_table "departmentdetails", force: :cascade do |t|
    t.integer "department_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_departmentdetails_on_department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_departments_on_employer_id"
  end

  create_table "disciplinaries", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.string "type"
    t.date "date"
    t.string "description"
    t.string "verdict"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_disciplinaries_on_employee_id"
  end

  create_table "employeebanks", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.string "bank_name"
    t.string "branch_name"
    t.string "account_name"
    t.string "bank_code"
    t.string "branch_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employeebanks_on_employee_id"
  end

  create_table "employeedetails", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.string "first_name"
    t.string "second_name"
    t.string "third_name"
    t.integer "national_id"
    t.string "job_role"
    t.string "gender"
    t.string "job_group"
    t.integer "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employeedetails_on_employee_id"
  end

  create_table "employeefinancials", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.string "nssf_number"
    t.string "nhif_number"
    t.string "kra_pin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employeefinancials_on_employee_id"
  end

  create_table "employeelocations", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.string "latitide"
    t.string "longitude"
    t.datetime "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employeelocations_on_employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.integer "department_id", null: false
    t.string "email"
    t.string "employee_number"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_employees_on_department_id"
  end

  create_table "employeeschedules", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.string "name"
    t.string "description"
    t.date "date"
    t.time "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employeeschedules_on_employee_id"
  end

  create_table "employeetasks", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.string "name"
    t.string "description"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employeetasks_on_employee_id"
  end

  create_table "employerbanks", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.string "bank_name"
    t.string "branch_name"
    t.string "account_name"
    t.string "bank_code"
    t.string "branch_code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_employerbanks_on_employer_id"
  end

  create_table "employerdetails", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_employerdetails_on_employer_id"
  end

  create_table "employerfinancials", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.string "nhif_number"
    t.string "nssf_number"
    t.string "kra_pin"
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

  create_table "payrates", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.string "name"
    t.string "description"
    t.decimal "daily_charge", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_payrates_on_employer_id"
  end

  create_table "payslips", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.date "month"
    t.integer "basic_pay"
    t.integer "deductions", default: 0
    t.integer "paye", default: 0
    t.integer "nhif", default: 0
    t.integer "nssf", default: 0
    t.integer "net_pay", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_payslips_on_employee_id"
  end

  add_foreign_key "attendances", "employees"
  add_foreign_key "departmentdetails", "departments"
  add_foreign_key "departments", "employers"
  add_foreign_key "disciplinaries", "employees"
  add_foreign_key "employeebanks", "employees"
  add_foreign_key "employeedetails", "employees"
  add_foreign_key "employeefinancials", "employees"
  add_foreign_key "employeelocations", "employees"
  add_foreign_key "employees", "departments"
  add_foreign_key "employeeschedules", "employees"
  add_foreign_key "employeetasks", "employees"
  add_foreign_key "employerbanks", "employers"
  add_foreign_key "employerdetails", "employers"
  add_foreign_key "employerfinancials", "employers"
  add_foreign_key "employerlocations", "employers"
  add_foreign_key "payrates", "employers"
  add_foreign_key "payslips", "employees"
end
