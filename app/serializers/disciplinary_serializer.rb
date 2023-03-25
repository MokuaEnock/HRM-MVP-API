class DisciplinarySerializer < ActiveModel::Serializer
  attributes :id, :name, :date, :description, :verdict
  has_one :employee
end
