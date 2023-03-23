class EmployerdetailsController < ApplicationController
  def create
    schedule = Employerdetail.create(sch_params)
    render json: schedule
  end

  def show
    schedule = Employerdetail.find(params[:id])
    render json: schedule
  end

  def index
    schedules = Employerdetail.all
    render json: schedules
  end

  def destroy
    schedule = Employerdetail.find(params[:id])
    schedule.destroy
    render json: schedule
  end

  def update
    schedule = Employerdetail.find(params[:id])
    schedule.update(sch_params)
    render json: schedule
  end

  private

  def sch_params
    params.permit(:name, :description, :date, :time, :employee_id)
  end
end
