class Attendance < ApplicationRecord
  belongs_to :employee

  # Calculate the total worked hours for this time sheet based on the time_in and time_out fields
  def calculate_total_worked_hours
    # Check if time_in and time_out are present
    if time_in.present? && time_out.present?
      # Calculate the total worked hours
      hours_worked = ((time_out - time_in) / 1.hour).round(2)
      # If this is a weekend, double the total worked hours
      if weekend?
        self.total_worked_hours = (hours_worked * 2).round(2)
      else
        self.total_worked_hours = hours_worked
      end
    else
      self.total_worked_hours = 0.0
    end
  end

  # Calculate the pay for this time sheet based on the total_worked_hours and whether it's a weekday or weekend
  def calculate_pay
    if total_worked_hours == 0
      self.pay = 0.0
    elsif weekday?
      self.pay = 776.0
    elsif weekend?
      self.pay = 2 * 776.0
    end
  end

  private

  # Determine whether this time sheet is on a weekday (Monday - Friday)
  def weekday?
    date.on_weekday?
  end

  # Determine whether this time sheet is on a weekend (Saturday - Sunday)
  def weekend?
    date.on_weekend?
  end

  def attendance_summary(user_id)
    employee = Employee.find(user_id)
    attendances = Attendance.where(employee_id: user_id)
    summary = {}

    attendances.each do |attendance|
      month = attendance.date.month
      year = attendance.date.year

      # Initialize the summary hash for this month and year if it doesn't exist
      summary[year] ||= {}
      summary[year][month] ||= {
        month_name: attendance.date.strftime("%B"),
        present_days: 0,
        absent_days: 0,
        total_pay: 0.0
      }

      # Increment the present_days or absent_days count depending on the attendance record
      if attendance.total_worked_hours > 0
        summary[year][month][:present_days] += 1
        summary[year][month][:total_pay] += attendance.pay
      else
        summary[year][month][:absent_days] += 1
      end
    end

    summary
  end
end
