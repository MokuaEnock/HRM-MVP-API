class EmployeecurrentsController < ApplicationController
  def index
    location = Employeecurrent.all
    render json: location
  end

  def create
    location = Employeecurrent.new(cur_params)
    if location.save
      render json: location, status: :created
    else
      render json: { errors: location.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    location = Employeecurrent.find(params[:id])
    render json: location
  end

  private

  def cur_params
    params.permit(:employee_id, :longitude, :latitude, :timestamps)
  end
end
