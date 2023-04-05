class EmployeecurrentSerializer < ActiveModel::Serializer
  attributes :id
  has_one :employee
end
