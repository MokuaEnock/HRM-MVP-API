class DepartmentSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :employer
  has_many :employees
end
