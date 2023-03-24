class EmployerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email

  has_many :departments
end
