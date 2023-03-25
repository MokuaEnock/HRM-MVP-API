class EmployeefinancialsSerializer < ActiveModel::Serializer
  attributes :id, :nhif_number, :nssf_number, :kra_pin

  belongs_to :employee
end
