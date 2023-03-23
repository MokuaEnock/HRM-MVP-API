class Employer < ApplicationRecord
  has_secure_password

  has_many :employerlocations
  has_many :employees
  has_many :employerbanks
  has_one :employerfinancial
end
