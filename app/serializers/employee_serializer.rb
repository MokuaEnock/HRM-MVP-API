class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :department
end
