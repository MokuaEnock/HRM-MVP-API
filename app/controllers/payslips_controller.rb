class PayslipsController < ApplicationController
  def index
  end

  def create
    payslip = Payslip.new(pay_params)
    payslip.payslip_period = payslip.calculate_payslip_period
    payslip.gross_salary = payslip.calculate_gross_salary
    payslip.nhif = payslip.nhif_deduction
  end

  def show
  end

  private

  def pay_params
    params.permit(:employee_id, :start_date, :end_date)
  end
end
