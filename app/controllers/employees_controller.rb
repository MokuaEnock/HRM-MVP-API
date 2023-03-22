class EmployeesController < ApplicationController
  def index
    employees = Employee.all
    render json: employees
  end

  def create
    employee = Employee.create(employee_params)
    render json: employee
  end

  def show
    render json: Employee.find(params[:id]), status: :ok
  end

  private

  def employee_params
    params.permit(:employer_id, :name)
  end
end
