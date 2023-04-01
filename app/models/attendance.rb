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
    if weekday? && total_worked_hours > 0
      self.pay = 772
    elsif weekend? && total_worked_hours > 0
      self.pay = total_worked_hours * 2 * 772
    else
      self.pay = 0.0
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
end
