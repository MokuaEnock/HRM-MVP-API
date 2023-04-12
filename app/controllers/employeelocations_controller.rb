class EmployeelocationsController < ApplicationController
  def create
    location = Employeelocation.create(loc_params)
    render json: location
  end

  def destroy
    location = Employeelocation.find_by(params[:id])
    location.destroy

    render json: location
  end

  def index
    render json: Employeelocation.all
  end

  def show
    location = Employeelocation.find_by(params[:id])
    render json: location
  end

  private

  def loc_params
    params.permit(:country, :county, :subcounty, :location, :employee_id)
  end
end
