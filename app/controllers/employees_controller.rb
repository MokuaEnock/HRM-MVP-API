class EmployeesController < ApplicationController
  def index
    employees = Employee.all
    render json: employees, each_serializer: EmployeeSerializer
  end

  def create
    employee = Employee.create(employee_params)
    render json: employee
  end

  def show
    @employee = Employee.find(params[:id])
    render json: @employee, serializer: EmployeeSerializer
  end

  private

  def employee_params
    params.permit(:department_id, :email, :employee_number, :password, :password_confirmation)
  end
end
