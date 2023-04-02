class Payslip < ApplicationRecord
  belongs_to :employee

  def calculate_payslip_period
    (end_date - start_date).to_i + 1
  end

  def calculate_gross_salary
    attendances = Attendance.where(employer_id: employee_id, date: start_date..end_date)
    total_pay = attendances.sum(:pay)
  end

  def nhif_deduction
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

  def nssf_deduction
    return 200
  end

  def calculate_taxable_income
    return calculate_taxable_income - nhif_deduction - nssf_deduction
  end
end
