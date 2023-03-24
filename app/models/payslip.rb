class Payslip < ApplicationRecord
  belongs_to :employee

  def gross_pay
  end

  def taxable_income
  end

  def income_tax
  end

  def deductions
  end

  private

  def calculate_income_tax(taxable_income)
    if taxable_income <= 0
      return 0
    elsif taxable_income <= 12298
      return (taxable_income * 0.1).round
    elsif taxable_income <= 23885
      return ((taxable_income - 12298) * 0.15 + 1229.80).round
    elsif taxable_income <= 35472
      return ((taxable_income - 23885) * 0.20 + 3214.70).round
    elsif taxable_income <= 47059
      return ((taxable_income - 35472) * 0.25 + 5641.20).round
    else
      return ((taxable_income - 47059) * 0.3 + 8965.20).round
    end
  end

  def calculate_nhif_deduction(total_earnings)
    if total_earnings <= 5999
      return 150
    elsif total_earnings <= 7999
      return 300
    elsif total_earnings <= 11999
      return 400
    elsif total_earnings <= 14999
      return 500
    elsif total_earnings <= 19999
      return 600
    elsif total_earnings <= 24999
      return 750
    elsif total_earnings <= 29999
      return 850
    elsif total_earnings <= 34999
      return 900
    elsif total_earnings <= 39999
      return 950
    elsif total_earnings <= 44999
      return 1000
    elsif total_earnings <= 49999
      return 1100
    elsif total_earnings <= 59999
      return 1200
    elsif total_earnings <= 69999
      return 1300
    elsif total_earnings <= 79999
      return 1400
    else
      return 1500
    end
  end
end
