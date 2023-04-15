class DepartmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :employer_id

  belongs_to :employer
  has_many :employees
end
