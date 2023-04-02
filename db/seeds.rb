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

# Create an array of all the dates from January 1st until today, excluding Sundays and occasional Saturdays
dates = (Date.parse("2023-01-01")..Date.today).select { |date| date.on_weekday? || (date.saturday? && rand(10) < 3) }

dates = (Date.parse("2023-01-01")..Date.today).select { |date| date.on_weekday? || (date.saturday? && rand(10) < 3) }.reject { |date| date.sunday? }

# Define the minimum and maximum hours an employee can attend in a day
MINIMUM_ATTENDANCE_HOURS = 7
MAXIMUM_ATTENDANCE_HOURS = 10

# Create seed data for each date for the two employees
dates.each do |date|
  Employee.all.each do |employee|
    # Check if employee will attend work on this day
    next if rand(10) < 3 || (date.saturday? && rand(10) < 7)

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
