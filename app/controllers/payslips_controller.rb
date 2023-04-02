class PayslipsController < ApplicationController
  def index
  end

  def create
    payslip = Payslip.new(pay_params)
    payslip.payslip_period = payslip.calculate_payslip_period
  end

  def show
  end

  private

  def pay_params
    params.permit(:employee_id, :start_date, :end_date)
  end
end
