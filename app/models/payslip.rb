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
    taxablae_income = calculate_taxable_income - nhif_deduction - nssf_deduction

    if taxable_income <= 0
      return 0
    elsif taxable_income <= 12298
      return taxable_income * 0.1
    elsif taxable_income <= 23885
      return (taxable_income - 12298) * 0.15 + 1229.8
    elsif taxable_income <= 35472
      return (taxable_income - 23885) * 0.2 + 3204.8
    elsif taxable_income <= 47059
      return (taxable_income - 35472) * 0.25 + 5630.8
    else
      return (taxable_income - 47059) * 0.3 + 8963.3
    end
  end

  def calculate_paye
    taxable_income = calculate_taxable_income
    if taxable_income <= 12298
      paye = 0.1 * taxable_income
    elsif taxable_income > 12298 && taxable_income <= 23885
      paye = 0.15 * (taxable_income - 12298) + 1229.80
    elsif taxable_income > 23885 && taxable_income <= 35472
      paye = 0.20 * (taxable_income - 23885) + 3457.80
    elsif taxable_income > 35472 && taxable_income <= 47059
      paye = 0.25 * (taxable_income - 35472) + 6028.80
    elsif taxable_income > 47059 && taxable_income <= 58646
      paye = 0.30 * (taxable_income - 47059) + 9728.80
    else
      paye = 0.35 * (taxable_income - 58646) + 14968.80
    end

    paye.round(2)
  end
end
