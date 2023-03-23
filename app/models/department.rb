class Department < ApplicationRecord
  belongs_to :employer
  has_many :employees
  has_one :departmentdetail
end
