class EmployeebanksController < ApplicationController
  def create
    schedule = Employeebank.create(sch_params)
    render json: schedule
  end

  def show
    schedule = Employeebank.find(params[:id])
    render json: schedule
  end

  def index
    schedules = Employeebank.all
    render json: schedules
  end

  def destroy
    schedule = Employeebank.find(params[:id])
    schedule.destroy
    render json: schedule
  end

  def update
    schedule = Employeebank.find(params[:id])
    schedule.update(sch_params)
    render json: schedule
  end

  private

  def sch_params
    params.permit(:bank_name, :branch_name, :account_name, :account_number, :bank_code, :branch_code, :employee_id)
  end
end
