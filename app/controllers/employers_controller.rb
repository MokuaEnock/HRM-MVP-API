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

    employer.departments.each do |department|
      total_employees += department.employees.count
      department.employees.each do |employee|
        total_gross_salary += employee.payslips.sum(:gross_salary)
        total_net_salary += employee.payslips.sum(:net_salary)
        total_deductions += (employee.payslips.sum(:nhif) + employee.payslips.sum(:nssf) + employee.payslips.sum(:paye) + employee.payslips.sum(:sacco) + employee.payslips.sum(:insurance))
      end
    end

    render json: {
      total_employees: total_employees,
      total_gross_salary: total_gross_salary,
      total_net_salary: total_net_salary,
      total_deductions: total_gross_salary - total_net_salary,
    }
  end

  def all_employees
    employer = Employer.find(params[:id])
    employees = []

    employer.departments.each do |department|
      department.employees.each do |employee|
        employee_data = {
          name: "#{employee.employeedetail.first_name} #{employee.employeedetail.second_name} #{employee.employeedetail.third_name}",
          gender: employee.employeedetail.gender,
          employee_number: employee.employeework.employee_number,
          department: department.name,
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
