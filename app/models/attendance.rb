class Attendance < ApplicationRecord
  belongs_to :employee

  def calculate_total_worked_hours
    # Check if time_in and time_out are present
    if time_in.present? && time_out.present?
      # Calculate the total worked hours
      hours_worked = ((time_out - time_in) / 1.hour).round(2)
      # Calculate overtime if the total worked hours exceed 8 hours
      if hours_worked > 8
        overtime_hours = hours_worked - 8
        self.overtime = overtime_hours
        self.total_worked_hours = 8.0
      else
        self.overtime = 0.0
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
      # Access the Employeework model for this employee and get the basic_salary attribute
      basic_salary = employee.employeework.basic_salary
      self.pay = basic_salary #/ 22.0 * total_worked_hours
      self.overtime_pay = ((basic_salary / 8) * 2 * overtime)
      self.total_salary = pay + overtime_pay
    elsif weekend?
      # Access the Employeework model for this employee and get the basic_salary attribute
      basic_salary = employee.employeework.basic_salary
      self.pay = basic_salary * 2 #/ 22.0 * total_worked_hours * 2
      self.overtime_pay = 0
      self.total_salary = pay + overtime_pay
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
