class AttendanceSerializer < ActiveModel::Serializer
  attributes :id, :in_time, :out_time, :reason, :timeIn, :timeOut, :date, :total_hours
end
