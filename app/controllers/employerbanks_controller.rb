class EmployerbanksController < ApplicationController
  def create
    schedule = Employerbank.create(sch_params)
    render json: schedule
  end

  def show
    schedule = Employerbank.find(params[:id])
    render json: schedule
  end

  def index
    schedules = Employerbank.all
    render json: schedules
  end

  def destroy
    schedule = Employerbank.find(params[:id])
    schedule.destroy
    render json: schedule
  end

  def update
    schedule = Employerbank.find(params[:id])
    schedule.update(sch_params)
    render json: schedule
  end

  private

  def sch_params
    params.permit(:bank_name, :branch_name, :account_name, :bank_code, :branch_code)
  end
end
