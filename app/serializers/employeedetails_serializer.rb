class EmployeedetailsSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :second_name, :third_name, :national_id, :job_role, :gender, :job_group, :phone

  belongs_to :employee
end
