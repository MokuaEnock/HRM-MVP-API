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

ActiveRecord::Schema[7.0].define(version: 2023_04_15_013641) do
  create_table "attendances", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.decimal "total_worked_hours", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "overtime", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "overtime_pay", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "pay", precision: 10, scale: 2, default: "0.0", null: false
    t.string "reason"
    t.decimal "total_salary", precision: 10, scale: 2
    t.time "time_in"
    t.time "time_out"
    t.date "date"
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
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_departments_on_employer_id"
  end

  create_table "disciplines", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.integer "points", default: 0
    t.string "name"
    t.string "description"
    t.date "reported_date"
    t.date "occurence_date"
    t.string "type"
    t.string "verdict"
    t.string "employee_statement"
    t.string "reason"
    t.string "action_taken"
    t.boolean "verbal_warning", default: false
    t.boolean "written_warning", default: false
    t.boolean "suspension", default: false
    t.boolean "termination", default: false
    t.string "suspension_reason"
    t.date "suspension_start"
    t.date "suspension_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_disciplines_on_employee_id"
  end

  create_table "employeebanks", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.string "bank_name"
    t.string "branch_name"
    t.string "account_name"
    t.integer "account_number"
    t.string "bank_code"
    t.string "branch_code"
    t.string "preferred_currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employeebanks_on_employee_id"
  end

  create_table "employeecontacts", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.integer "phone_number"
    t.string "email_address"
    t.integer "whatsapp_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employeecontacts_on_employee_id"
  end

  create_table "employeecurrents", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.string "longitude"
    t.string "latitude"
    t.string "timestamps"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employeecurrents_on_employee_id"
  end

  create_table "employeedetails", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.string "first_name"
    t.string "second_name"
    t.string "third_name"
    t.integer "national_id"
    t.string "gender"
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

  create_table "employeeinsuarances", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.string "name"
    t.string "registration_number"
    t.string "bank_name"
    t.string "bank_branch"
    t.string "bank_account_number"
    t.string "bank_account_name"
    t.string "premium_type"
    t.string "policy_number"
    t.string "premium_amount"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employeeinsuarances_on_employee_id"
  end

  create_table "employeelocations", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.string "country"
    t.string "county"
    t.datetime "subcounty"
    t.datetime "location"
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

  create_table "employeesaccos", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.string "name"
    t.string "registration_number"
    t.string "bank_name"
    t.string "bank_branch"
    t.string "bank_account_name"
    t.string "bank_account_number"
    t.string "membership_number"
    t.integer "contribution_amount"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employeesaccos_on_employee_id"
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
    t.integer "status", default: 0
    t.integer "priority", default: 0
    t.integer "estimated_hours"
    t.integer "actual_hours"
    t.datetime "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employeetasks_on_employee_id"
  end

  create_table "employeeworks", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.integer "basic_salary"
    t.string "employee_role"
    t.string "employee_number"
    t.string "employee_job_group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employeeworks_on_employee_id"
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
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.decimal "nhif", precision: 10, scale: 2, null: false
    t.decimal "nssf", precision: 10, scale: 2, null: false
    t.decimal "paye", precision: 10, scale: 2, null: false
    t.decimal "taxable_income", precision: 10, scale: 2, null: false
    t.integer "payslip_period"
    t.integer "gross_salary"
    t.integer "net_salary"
    t.decimal "sacco", precision: 10, scale: 2, null: false
    t.decimal "insurance", precision: 10, scale: 2, null: false
    t.integer "rating"
    t.string "performance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_payslips_on_employee_id"
  end

  add_foreign_key "attendances", "employees"
  add_foreign_key "departmentdetails", "departments"
  add_foreign_key "departments", "employers"
  add_foreign_key "disciplines", "employees"
  add_foreign_key "employeebanks", "employees"
  add_foreign_key "employeecontacts", "employees"
  add_foreign_key "employeecurrents", "employees"
  add_foreign_key "employeedetails", "employees"
  add_foreign_key "employeefinancials", "employees"
  add_foreign_key "employeeinsuarances", "employees"
  add_foreign_key "employeelocations", "employees"
  add_foreign_key "employees", "departments"
  add_foreign_key "employeesaccos", "employees"
  add_foreign_key "employeeschedules", "employees"
  add_foreign_key "employeetasks", "employees"
  add_foreign_key "employeeworks", "employees"
  add_foreign_key "employerbanks", "employers"
  add_foreign_key "employerdetails", "employers"
  add_foreign_key "employerfinancials", "employers"
  add_foreign_key "employerlocations", "employers"
  add_foreign_key "payrates", "employers"
  add_foreign_key "payslips", "employees"
end
