class Payslip < ApplicationRecord
  belongs_to :employee

  def calculate_payslip_period
    (end_date - start_date).to_i + 1
  end
end

# def gross_pay
# end

# def taxable_income
# end

# def income_tax
# end

# def deductions
# end

# private

# def calculate_income_tax(taxable_income)
#   if taxable_income <= 0
#     return 0
#   elsif taxable_income <= 12298
#     return (taxable_income * 0.1).round
#   elsif taxable_income <= 23885
#     return ((taxable_income - 12298) * 0.15 + 1229.80).round
#   elsif taxable_income <= 35472
#     return ((taxable_income - 23885) * 0.20 + 3214.70).round
#   elsif taxable_income <= 47059
#     return ((taxable_income - 35472) * 0.25 + 5641.20).round
#   else
#     return ((taxable_income - 47059) * 0.3 + 8965.20).round
#   end
# end

# def calculate_nhif_deduction(total_earnings)
#   if total_earnings <= 5999
#     return 150
#   elsif total_earnings <= 7999
#     return 300
#   elsif total_earnings <= 11999
#     return 400
#   elsif total_earnings <= 14999
#     return 500
#   elsif total_earnings <= 19999
#     return 600
#   elsif total_earnings <= 24999
#     return 750
#   elsif total_earnings <= 29999
#     return 850
#   elsif total_earnings <= 34999
#     return 900
#   elsif total_earnings <= 39999
#     return 950
#   elsif total_earnings <= 44999
#     return 1000
#   elsif total_earnings <= 49999
#     return 1100
#   elsif total_earnings <= 59999
#     return 1200
#   elsif total_earnings <= 69999
#     return 1300
#   elsif total_earnings <= 79999
#     return 1400
#   else
#     return 1500
#   end
# end

# def calculate_nssf_deduction(total_earnings)
#   # upper_earning_limit = 18000
#   # lower_earning_limit = 6000
#   # pensionable_wages = [total_earnings, upper_earning_limit].min - lower_earning_limit
#   # employee_contribution = [pensionable_wages * 0.06, upper_earning_limit * 0.06].min
#   # employer_contribution = [pensionable_wages * 0.06, upper_earning_limit * 0.06].min
#   # total_contribution = employee_contribution + employer_contribution
#   # tier_1_contribution = [total_contribution, 720].min
#   # tier_2_contribution = [total_contribution - tier_1_contribution, 1440].min
#   # return tier_1_contribution + tier_2_contribution
#   return 200
# end

# def calculate_total_deductions(taxable_income, total_earnings)
#   paye_deduction = calculate_income_tax(taxable_income)
#   nhif_deduction = calculate_nhif_deduction(total_earnings)
#   nssf_deduction = calculate_nssf_deduction(total_earnings)
#   total_deductions = paye_deduction + nhif_deduction + nssf_deduction
#   return total_deductions
# end

# def calculate_net_pay(gross_pay, total_deductions)
#   net_pay = gross_pay - total_deductions
#   return net_pay
# end
