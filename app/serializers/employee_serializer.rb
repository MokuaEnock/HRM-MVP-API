class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :email, :employee_number, :department_id

  belongs_to :department
  has_one :employeedetail
  has_one :employeebank
  has_many :employeelocations
  has_one :employeefinancial
  has_many :employeetasks
  has_many :disciplinaries
  has_many :employeesaccos
  has_many :employeeinsuarances
end
