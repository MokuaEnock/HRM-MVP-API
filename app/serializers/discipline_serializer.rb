class DisciplineSerializer < ActiveModel::Serializer
  attributes :id
  has_one :Employee
end
