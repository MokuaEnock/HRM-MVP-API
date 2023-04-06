class Payslip < ApplicationRecord
  belongs_to :employee
  validate :start_and_end_dates

  def start_and_end_dates
    if start_date.nil? || end_date.nil?
      errors.add(:end_date, "Start date and end date must be present.")
    elsif (end_date - start_date).to_i != 13
      errors.add(:end_date, "The payslip period must be exactly 14 days.")
    end
  end

  def calculate_payslip_period
    (end_date - start_date).to_i + 1
  end

  def calculate_gross_salary
    attendances = Attendance.where(employee_id: employee_id, date: start_date..end_date)
    total_pay = attendances.sum(:total_salary)
  end

  def calculate_nhif_deduction
    case calculate_gross_salary
    when 0..5999
      150
    when 6000..7999
      300
    when 8000..11999
      400
    when 12000..14999
      500
    when 15000..19999
      600
    when 20000..24999
      750
    when 25000..29999
      850
    when 30000..34999
      900
    when 35000..39999
      950
    else
      1000
    end
  end

  def calculate_nssf_deduction
    return 200
  end

  def calculate_taxable_income
    taxable_income = calculate_gross_salary - calculate_nhif_deduction - calculate_nssf_deduction
    return [taxable_income, 0].max
  end

  def calculate_paye
    taxable_income = calculate_taxable_income
    paye = 0

    if taxable_income <= 12298
      paye = 0.1 * taxable_income
    elsif taxable_income <= 23885
      paye = 0.15 * (taxable_income - 12298) + 1229.80
    elsif taxable_income <= 35472
      paye = 0.2 * (taxable_income - 23885) + 3204.80
    elsif taxable_income <= 47059
      paye = 0.25 * (taxable_income - 35472) + 5630.80
    else
      paye = 0.3 * (taxable_income - 47059) + 8963.30
    end

    return paye.round(2)
  end

  def calculate_net_salary
    gross_salary = calculate_gross_salary
    paye = calculate_paye
    nhif = calculate_nhif_deduction
    nssf = calculate_nssf_deduction
    net_salary = gross_salary - paye - nhif - nssf
    return net_salary.round(2)
  end

  def calculate_attendance_data
    attendance_dates = (start_date..end_date).to_a
    attendances = Attendance.where(employee_id: employee_id, date: start_date..end_date)
    attendance_hours = {}
    attendance_pay = {}
    attendance_dates.each do |date|
      attendance_hours[date] = 0
      attendance_pay[date] = 0
    end
    attendances.each do |attendance|
      attendance_hours[attendance.date] = attendance.total_worked_hours
      attendance_pay[attendance.date] = attendance.pay
    end
    attendance_hours = attendance_hours.sort.to_h
    attendance_pay = attendance_pay.sort.to_h
    attendance_data = {
      dates: attendance_hours.keys,
      hours_worked: attendance_hours.values,
      pay: attendance_pay.values,
    }
    return attendance_data
  end

  def calculate_sacco_deduction
    saccos = Employeesacco.where(employee_id: employee_id)
    sacco_contributions = []

    if saccos.present?
      saccos.each do |sacco|
        sacco_amount = sacco.contribution_amount
        sacco_contributions << sacco_amount
      end
    end

    total_sacco_deduction = sacco_contributions.sum
    return total_sacco_deduction
  end

  def calculate_insurance_deduction
    insurance_deduction = 0

    # Retrieve all insurances belonging to employee
    insurances = Employeeinsuarance.where(employee_id: employee_id)

    if insurances.present?
      # Calculate deduction for each insurance and add to total
      insurance_deductions = []
      insurances.each do |insurance|
        insurance_amount = insurance.premium_amount.to_i
        insurance_deductions.push(insurance_amount)
      end
      insurance_deduction = insurance_deductions.sum
    else
      # If no insurances, set deduction to zero
      insurance_deduction = 0
    end

    return insurance_deduction
  end
end
