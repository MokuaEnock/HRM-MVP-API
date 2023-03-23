class Employee < ApplicationRecord
  belongs_to :department
  
  has_one :employeedetail
end
