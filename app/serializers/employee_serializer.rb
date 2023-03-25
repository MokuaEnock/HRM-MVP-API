class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :email, :employee_number, :department_id

  belongs_to :department
end
