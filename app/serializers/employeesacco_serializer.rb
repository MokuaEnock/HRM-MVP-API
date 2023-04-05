class EmployeesaccoSerializer < ActiveModel::Serializer
  attributes :id
  has_one :employee
end
