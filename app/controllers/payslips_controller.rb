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
      payslip.sacco = payslip.calculate_sacco_deduction
      payslip.insurance = payslip.calculate_insurance_deduction

      if payslip.save
        # do something if the payslip was successfully saved
      else
        # do something if there was an error saving the payslip
      end
    end

    render json: { message: "Payslips generated successfully" }, status: :created
  end

  def payslip
    employee = Employee.find(params[:employee_id])
    payslips_data = Payslip.last_five_for_employee(employee.id)

    render json: payslips_data, status: :ok
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

  def calculate_payslip_totals
    @payslips = Payslip.all.order(:start_date)
    payslip_totals = {}
    @payslips.each do |payslip|
      period = payslip.start_date.strftime("%b %Y")
      payslip_totals[period] ||= {}
      payslip_totals[period][:gross_salary] ||= 0
      payslip_totals[period][:nhif_deduction] ||= 0
      payslip_totals[period][:nssf_deduction] ||= 0
      payslip_totals[period][:paye] ||= 0
      payslip_totals[period][:net_salary] ||= 0

      payslip_totals[period][:gross_salary] += payslip.calculate_gross_salary
      payslip_totals[period][:nhif_deduction] += payslip.calculate_nhif_deduction
      payslip_totals[period][:nssf_deduction] += payslip.calculate_nssf_deduction
      payslip_totals[period][:paye] += payslip.calculate_paye
      payslip_totals[period][:net_salary] += payslip.calculate_net_salary
    end
    render json: payslip_totals
  end

  def generate_data
    # find the most recent complete pay period
    payslip_period = Payslip.select(:payslip_period).distinct.order(payslip_period: :desc).first.payslip_period

    # get all employees who have a payslip in the most recent complete pay period
    employees = Employee.joins(:payslips).where(payslips: { payslip_period: payslip_period }).distinct

    # initialize an array to hold the generated data for each employee
    data = []

    employees.each do |employee|
      # get the employee's details
      employee_details = employee.employeedetails

      # get the employee's bank details
      employee_banks = employee.employeebanks

      # get the payslips for the most recent complete pay period
      payslips = employee.payslips.where(payslip_period: payslip_period)

      # add the generated data to the array
      payslips.each do |payslip|
        data << {
          employee_name: "#{employee_details.first_name} #{employee_details.second_name} #{employee_details.third_name}",
          bank_name: employee_banks.bank_name,
          bank_code: employee_banks.bank_code,
          bank_account_number: employee_banks.bank_account_number,
          branch_name: employee_banks.branch_name,
          payroll_number: payslip.id,
          net_salary: payslip.net_salary,
        }
      end
    end

    render json: data, status: :ok
  end

  private

  def pay_params
    params.require(:payslip).permit(:employee_id, :start_date, :end_date)
  end
end
