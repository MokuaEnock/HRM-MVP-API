class Employee < ApplicationRecord
  belongs_to :department

  has_one :employeedetail
  has_one :employeebank
  has_many :employeelocations
end
