class Employee < ApplicationRecord
  has_secure_password

  belongs_to :department

  has_one :employeedetail
  has_one :employeebank
  has_one :employeefinancial
  has_many :employeelocations
  has_many :attendances
  has_many :payslips
  has_many :disciplinaries
  has_one :employeework
  has_many :employeesaccos
  has_many :employeeinsuarances

  has_many :employeetasks
end
