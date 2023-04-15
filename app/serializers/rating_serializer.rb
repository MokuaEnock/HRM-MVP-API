class RatingSerializer < ActiveModel::Serializer
  attributes :id
  has_one :Employee
end
