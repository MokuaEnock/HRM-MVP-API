class EmployeeschedulesController < ApplicationController
  def create
    schedule = Employeeschedule.create(sch_params)
    render json: schedule
  end

  def show
  end

  def index
    render json: Employeeschedule.all
  end

  def destroy
  end

  private

  def sch_params
    params.permit(:name, :description, :date, :time, :employee_id)
  end
end
