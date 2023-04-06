# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie:
#   .first)

puts "seeding"

employers = Employer.create([{ name: "Star Wars", email: "star@gmail.com", password: "star", password_confirmation: "star" },
                             { name: "Lord of the Rings", email: "lord@gmail.com", password: "lord", password_confirmation: "lord" }])

departments = Department.create([{ employer_id: 1, email: "engineering@gmail.com", name: "Engineering", password: "engineering", password_confirmation: "engineering" },
                                 { employer_id: 2, email: "customer@gmail.com", name: "Customer", password: "engineering", password_confirmation: "engineering" }])

employees = Employee.create([{ department_id: 1, email: "mokua@enock.com", employee_number: "zab3", password: "enock", password_confirmation: "enock" },
                             { department_id: 1, email: "leila@kem.com", employee_number: "kem2", password: "enock", password_confirmation: "enock" }])
# employee saccos
Employeesacco.create(employee_id: 1, name: "John's Savings Account", registration_number: "12345", bank_name: "Bank of America", bank_branch: "Downtown Branch", bank_account_name: "John Doe", bank_account_number: "9876543210", membership_number: "56789", contribution_amount: 1000, start_date: Date.new(2023, 1, 1), end_date: Date.new(2022, 12, 31))
Employeesacco.create(employee_id: 2, name: "Jane's Checking Account", registration_number: "67890", bank_name: "Chase Bank", bank_branch: "Midtown Branch", bank_account_name: "Jane Smith", bank_account_number: "1234567890", membership_number: "98765", contribution_amount: 1500, start_date: Date.new(2023, 1, 1), end_date: Date.new(2022, 12, 31))

#employee insurance

# Seed data for employeeinsurance 1
employeeinsurance1 = Employeeinsuarance.create!(
  employee_id: 1,
  name: "John Doe Insurance",
  registration_number: "JD001",
  bank_name: "ABC Bank",
  bank_branch: "Nairobi",
  bank_account_number: "1234567890",
  bank_account_name: "John Doe",
  premium_type: "Life Insurance",
  policy_number: "LI001",
  premium_amount: "5000",
  start_date: Date.today - 1.month,
  end_date: Date.today + 11.months,
)

# Seed data for employeeinsurance 2
employeeinsurance2 = Employeeinsuarance.create!(
  employee_id: 2,
  name: "Jane Smith Insurance",
  registration_number: "JS001",
  bank_name: "XYZ Bank",
  bank_branch: "Mombasa",
  bank_account_number: "0987654321",
  bank_account_name: "Jane Smith",
  premium_type: "Medical Insurance",
  policy_number: "MI001",
  premium_amount: "7500",
  start_date: Date.today,
  end_date: Date.today + 1.year,
)


# Seed data for employeework 1
employeework1 = Employeework.create!(
  employee_id: 1,
  basic_salary: 800,
  employee_role: "Software Engineer",
  employee_number: "JD001",
  employee_job_group: "Level 2"
)

# Seed data for employeework 2
employeework2 = Employeework.create!(
  employee_id: 2,
  basic_salary: 700,
  employee_role: "Project Manager",
  employee_number: "JS001",
  employee_job_group: "Level 3"
)

# Attendance data
# Create an array of all the dates from January 1st until today, excluding Sundays and occasional Saturdays
dates = (Date.parse("2023-01-01")..Date.today).select { |date| date.on_weekday? || (date.saturday? && rand(10) < 3) }.reject { |date| date.sunday? }

# Define the minimum and maximum hours an employee can attend in a day
MINIMUM_ATTENDANCE_HOURS = 7
MAXIMUM_ATTENDANCE_HOURS = 10

# Create seed data for each date for the two employees
dates.each do |date|
  Employee.all.each do |employee|
    # Randomly generate time_in and time_out values within the workday hours
    attendance_hours = rand(MINIMUM_ATTENDANCE_HOURS..MAXIMUM_ATTENDANCE_HOURS)
    time_in = date + rand(8..9).hours
    time_out = time_in + attendance_hours.hours

    # Create a new attendance record with the employee_id, date, time_in, and time_out
    attendance = Attendance.new(employee_id: employee.id, date: date, time_in: time_in, time_out: time_out)
    attendance.calculate_total_worked_hours
    attendance.calculate_pay
    attendance.save
  end
end

puts "done seeding"
