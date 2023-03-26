class AttendanceSerializer < ActiveModel::Serializer
  attributes :id, :in_time, :out_time, :reason, :timein, :timeout, :date
end
