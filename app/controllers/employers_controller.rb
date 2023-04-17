class EmployersController < ApplicationController
  def index
    render json: Employer.all
  end

  def create
    employer = Employer.new(employer_params)
    if employer.save
      render json: { id: employer.id }
    else
      render json: { errors: employer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @employer = Employer.find(params[:id])
    render json: @employer, serializer: EmployerSerializer
  end

  def total_employees
    employer = Employer.find(params[:id])
    total_employees = 0
    total_gross_salary = 0
    total_net_salary = 0
    total_deductions = 0
    total_absent_days = 0
    total_present_days = 0

    employer.departments.each do |department|
      department.employees.each do |employee|
        total_employees += 1
        payslips = employee.payslips
        total_gross_salary += payslips.sum(:gross_salary)
        total_net_salary += payslips.sum(:net_salary)
        # total_deductions += (payslips.sum(:nhif) + payslips.sum(:nssf) + payslips.sum(:paye) + payslips.sum(:sacco) + payslips.sum(:insurance))
        total_absent_days += payslips.sum(:days_absent)
        total_present_days += payslips.sum(:days_present)
      end
    end

    total = [
      total_employees: total_employees,
      total_gross_salary: total_gross_salary,
      total_net_salary: total_net_salary,
      total_deductions: total_gross_salary - total_net_salary,
      total_absent_days: total_absent_days,
      total_present_days: total_present_days,
    ]

    render json: total
  end

  def all_employees
    employer = Employer.find(params[:id])
    employees = []

    employer.departments.each do |department|
      department.employees.each do |employee|
        employee_data = {
          name: "#{employee.employeedetail.first_name} #{employee.employeedetail.second_name} #{employee.employeedetail.third_name}",
          gender: employee.employeedetail.gender,
          id: employee.id,
          employee_number: employee.employeework.employee_number,
          department: department.name,
          total_absent_days: employee.payslips.sum(:days_absent),
          total_present_days: employee.payslips.sum(:days_present),
          total_gross_pay: employee.payslips.sum(:gross_salary),
          total_net_pay: employee.payslips.sum(:net_salary),
        }
        employees << employee_data
      end
    end

    render json: { employees: employees }
  end

  private

  def employer_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
