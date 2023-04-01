class Attendance < ApplicationRecord
  belongs_to :employee

  validates :date, presence: true
  validates :clock_in, presence: true
  validates :clock_out, presence: true
  validates :employee_id, presence: true

  before_save :calculate_pay, :calculate_total_worked_hours

  private

  def calculate_pay
    #calculate pay for weekdays
    if date.wday.between?(1, 5) && worked_hours > 0 && worked_hours <= 8
      self.pay = worked_hours * 772 #772/8 hours = 96.5 per hour
    end

    #calculate pay for weekends
    if date.wday.between?(6, 7) && worked_hours > 0 && worked_hours <= 8
      self.pay = worked_hours * 193 #772/4 hours = 193 per hour (double pay)
    end
  end

  def calculate_total_worked_hours
    self.total_worked_hours = worked_hours.round(2)
  end

  def worked_hours
    hours = clock_out.hour - clock_in.hour
    minutes = (clock_out.min - clock_in.min) / 60.0
    hours + minutes
  end
end
