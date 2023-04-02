class PayslipsController < ApplicationController
  def index
    payslips = Payslip.all
    render json: payslips, status: :ok
  end

  def create
    payslip = Payslip.new(pay_params)
    payslip.payslip_period = payslip.calculate_payslip_period
    payslip.gross_salary = payslip.calculate_gross_salary
    payslip.nhif = payslip.nhif_deduction
    payslip.nssf = payslip.nssf_deduction
    payslip.taxable_income = payslip.calculate_taxable_income
    payslip.paye = payslip.calculate_paye
    payslip.net_salary = payslip.calculate_net_salary

    if payslip.save
      render json: payslip, status: :created
    else
      render json: payslip.errors, status: :unprocessable_entity
    end
  end

  def show
    payslip = Payslip.find(params[:id])
    render json: payslip, status: :ok
  end

  private

  def pay_params
    params.require(:payslip).permit(:employee_id, :start_date, :end_date)
  end
end
