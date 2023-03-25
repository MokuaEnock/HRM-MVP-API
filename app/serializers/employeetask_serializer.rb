class EmployeetaskSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :employee
end
