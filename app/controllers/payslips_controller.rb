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
    payslip = Payslip.where(employee_id: employee.id).last
    deductions = {
      nhif: payslip.nhif,
      sacco: payslip.sacco,
      insurance: payslip.insurance,
      nssf: payslip.nssf,
      paye: payslip.paye,
    }

    employee_details = {
      name: employee.email,
      basic_salary: employee.employeework.basic_salary,
      payslip_id: payslip.id,

    }

    employee_pay = {
      net_pay: payslip.net_salary,
      gross_pay: payslip.gross_salary,
    }

    payslip_period = {
      start_date: payslip.start_date,
      end_date: payslip.end_date,
      payslip_period: payslip.payslip_period,
    }

    week1_dates = {
      start_of_week: payslip.start_date,
      end_of_week: payslip.start_date + 6.days,
    }
    week1_dates[:dates] = (week1_dates[:start_of_week]..week1_dates[:end_of_week]).map { |date| date.strftime("%Y-%m-%d") }

    week2_dates = {
      start_of_week: payslip.end_date - 6.days,
      end_of_week: payslip.end_date,
    }
    week2_dates[:dates] = (week2_dates[:start_of_week]..week2_dates[:end_of_week]).map { |date| date.strftime("%Y-%m-%d") }

    payslip_data = {
      deductions: deductions,
      employee_details: employee_details,
      employee_pay: employee_pay,
      payslip_period: payslip_period,
      week1: week1_dates,
      week2: week2_dates,
    }

    render json: payslip_data, status: :ok
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

  private

  def pay_params
    params.require(:payslip).permit(:employee_id, :start_date, :end_date)
  end
end
