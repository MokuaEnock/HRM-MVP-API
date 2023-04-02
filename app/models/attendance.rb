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

  def self.attendance_summary_for_employee(employee_id)
    # Get all attendances for the employee
    attendances = where(employee_id: employee_id)

    # Group attendances by month
    attendances_by_month = attendances.group_by { |attendance| attendance.date.month }

    # Calculate attendance summary for each month
    attendance_summary_by_month = {}
    attendances_by_month.each do |month, attendances|
      # Get the first and last day of the month
      year = attendances.first.date.year
      start_date = Date.new(year, month, 1)
      end_date = start_date.end_of_month

      # Calculate total days present and absent, and total pay received
      total_present_days = attendances.count { |attendance| attendance.total_worked_hours > 0 && attendance.date.between?(start_date, end_date) }
      total_absent_days = end_date.day - total_present_days
      total_pay_received = attendances.sum(:pay)

      # Add the attendance summary to the hash
      attendance_summary_by_month[month] = {
        present_days: total_present_days,
        absent_days: total_absent_days,
        total_pay: total_pay_received,
      }
    end

    # Return the attendance summary for all months
    attendance_summary_by_month
  end
end
