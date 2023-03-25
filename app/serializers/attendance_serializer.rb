class AttendanceSerializer < ActiveModel::Serializer
  attributes :id, :date, :time_in, :time_out, :is_present, :is_late, :reason
  
end
