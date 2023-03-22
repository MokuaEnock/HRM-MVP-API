class Employer < ApplicationRecord
  has_secure_password

  has_many :employerlocations
  has_many :employees
end
