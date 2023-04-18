class DepartmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :employer_id, :department_number

  belongs_to :employer
  has_many :employees
end
