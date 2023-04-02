class PayslipsController < ApplicationController
  def index
    payslips = Payslip.all
    render json: payslips, status: :ok
  end

  def create
    employees = Employee.all

    employees.each do |employee|
      payslip = Payslip.new(pay_params)
      payslip.employee = employee
      payslip.payslip_period = payslip.calculate_payslip_period
      payslip.gross_salary = payslip.calculate_gross_salary
      payslip.nhif = payslip.calculate_nhif_deduction
      payslip.nssf = payslip.calculate_nssf_deduction
      payslip.taxable_income = payslip.calculate_taxable_income
      payslip.paye = payslip.calculate_paye
      payslip.net_salary = payslip.calculate_net_salary

      if payslip.save
        # do something if the payslip was successfully saved
      else
        # do something if there was an error saving the payslip
      end
    end

    render json: { message: "Payslips generated successfully" }, status: :created
  end

  def show
    payslip = Payslip.find(params[:id])
    render json: {
      payslip: payslip,
      attendance_data: payslip.attendance_data,
    }, status: :ok
  end

  private

  def pay_params
    params.require(:payslip).permit(:employee_id, :start_date, :end_date)
  end
end
