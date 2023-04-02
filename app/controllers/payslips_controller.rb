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
    employee = Employee.find(params[:id])
    payslips = employee.payslips
    payslip_data = []

    payslips.each do |payslip|
      payslip_data << {
        payslip: payslip,
        attendance_data: payslip.calculate_attendance_data,
      }
    end

    render json: payslip_data, status: :ok
  end

  def totals
    payslips = Payslip.all
    gross_salary_total = payslips.sum(:gross_salary)
    nhif_total = payslips.sum(:nhif)
    nssf_total = payslips.sum(:nssf)
    taxable_income_total = payslips.sum(:taxable_income)
    paye_total = payslips.sum(:paye)
    net_salary_total = payslips.sum(:net_salary)

    render json: {
      gross_salary_total: gross_salary_total,
      nhif_total: nhif_total,
      nssf_total: nssf_total,
      taxable_income_total: taxable_income_total,
      paye_total: paye_total,
      net_salary_total: net_salary_total,
    }, status: :ok
  end

  private

  def pay_params
    params.require(:payslip).permit(:employee_id, :start_date, :end_date)
  end
end
