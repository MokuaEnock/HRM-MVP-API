class DepartmentSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :employer
end
