class EmployeeworksController < ApplicationController
  def index
    render json: Employeework.all
  end

  def show
    works = Employeework.find(params[:id])
    render json: works
  end

  def create
    work = Employeework.create(emp_params)
    render json: work
  end

  private

  def emp_params
    params.permit(:employee_id, :basic_salary, :employee_role, :employee_number, :employee_job_group)
  end
end
