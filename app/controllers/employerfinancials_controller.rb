class EmployerfinancialsController < ApplicationController
  def create
    schedule = Employerfinancial.create(sch_params)
    render json: schedule
  end

  def show
    schedule = Employerfinancial.find(params[:id])
    render json: schedule
  end

  def index
    schedules = Employerfinancial.all
    render json: schedules
  end

  def destroy
    schedule = Employerfinancial.find(params[:id])
    schedule.destroy
    render json: schedule
  end

  def update
    schedule = Employerfinancial.find(params[:id])
    schedule.update(sch_params)
    render json: schedule
  end

  private

  def sch_params
    params.permit(:nhif_number, :nssf_number, :kra_pin)
  end
end
