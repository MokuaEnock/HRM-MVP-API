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

departments = Department.create([{ employer_id: 1, }])
puts "done seeding"
