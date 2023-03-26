class Department < ApplicationRecord
  has_secure_password

  belongs_to :employer
  has_many :employees
  has_one :departmentdetail
  has_many :attendances, through: :employees
end
