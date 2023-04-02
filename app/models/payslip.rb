class Payslip < ApplicationRecord
  belongs_to :employee

  def calculate_payslip_period
    (end_date - start_date).to_i + 1
  end

  def calculate_gross_salary
    attendances = Attendance.where(employer_id: employee_id, date: start_date..end_date)
    total_pay = attendances.sum(:pay)
  end

  def calculate_nhif_deduction(gross_salary)
    case gross_salary
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

  def calculate_nssf_deduction(gross_salary)
    return 0.06 * [gross_salary, 18000].min
  end

  def calculate_taxable_income
    taxable_income = calculate_gross_salary - calculate_nhif_deduction(employee.gross_salary) - calculate_nssf_deduction(employee.gross_salary)
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
    nhif = calculate_nhif_deduction(employee.gross_salary)
    nssf = calculate_nssf_deduction(employee.gross_salary)
    net_salary = gross_salary - paye - nhif - nssf
    return net_salary.round(2)
  end
end
