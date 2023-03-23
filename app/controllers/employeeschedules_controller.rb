class EmployeeschedulesController < ApplicationController
  def create
    # create a new Employeeschedule instance with permitted parameters from sch_params method
    schedule = Employeeschedule.create(sch_params)
    # render the created schedule as JSON
    render json: schedule
  end

  def show
    # find the Employeeschedule by its ID
    schedule = Employeeschedule.find(params[:id])
    # render the found schedule as JSON
    render json: schedule
  end

  def index
    # fetch all the Employeeschedules from the database
    schedules = Employeeschedule.all
    # render the fetched schedules as JSON
    render json: schedules
  end

  def destroy
    # find the Employeeschedule by its ID
    schedule = Employeeschedule.find(params[:id])
    # destroy the found Employeeschedule instance
    schedule.destroy
    # return the destroyed Employeeschedule as JSON
    render json: schedule
  end

  def update
    # find the Employeeschedule by its ID
    schedule = Employeeschedule.find(params[:id])
    # update the found Employeeschedule instance with permitted parameters from sch_params method
    schedule.update(sch_params)
    # render the updated schedule as JSON
    render json: schedule
  end

  private

  def sch_params
    # permit and return the required parameters for Employeeschedule creation
    params.permit(:name, :description, :date, :time, :employee_id)
  end
end
