class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :email, :employee_number, :department_id

  belongs_to :department
  has_one :employeedetails
  has_one :employeebanks
  has_many :employeelocations
  has_one :employeefinancial
end
