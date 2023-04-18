class DepartmentsController < ApplicationController
  def create
    depts = Department.create(dep_params)
    render json: depts
  end

  def index
    render json: Department.all
  end

  def show
    @department = Department.find(params[:id])
    render json: @department, serializer: DepartmentSerializer
  end

  def download_pay
    department = Department.find(params[:id])
    employees = department.employees
    data = []
    employees.each do |employee|
      last_payslip = employee.payslips.order(created_at: :desc).first
      next unless last_payslip # skip if the employee has no payslips
      employee_data = {
        name: "#{employee.employeedetail.first_name} #{employee.employeedetail.second_name} #{employee.employeedetail.third_name}",
        bank_account: employee.employeebank.account_number,
        bank_code: employee.employeebank.bank_code,
        branch_code: employee.employeebank.branch_code,
        bank_name: employee.employeebank.bank_name,
        amount: last_payslip.net_salary,
        payroll_no: last_payslip.id,

      }
      data << employee_data
    end
    render json: data
  end

  def create_multiple
    departments = []
    params["_json"].each do |department_params|
      departments << Department.create(department_params.permit(:name, :email, :password, :password_confirmation, :department_number, :employer_id))
    end
    render json: departments
  end

  private

  def dep_params
    params.permit(:name, :email, :password, :department_number, :password_confirmation, :employer_id)
  end
end
