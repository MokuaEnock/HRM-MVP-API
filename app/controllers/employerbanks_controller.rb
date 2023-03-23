class EmployerbanksController < ApplicationController
  def create
    schedule = Employeeschedule.create(sch_params)
    render json: schedule
  end

  def show
    schedule = Employeeschedule.find(params[:id])
    render json: schedule
  end

  def index
    schedules = Employeeschedule.all
    render json: schedules
  end

  def destroy
    schedule = Employeeschedule.find(params[:id])
    schedule.destroy
    render json: schedule
  end

  private

  def sch_params
    params.permit(:name, :description, :date, :time, :employee_id)
  end
end
