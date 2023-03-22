class EmployerlocationsController < ApplicationController
  def index
    render json: Employerlocation.all
  end

  def create
    locations = Employerlocation.create(loc_params)
    render json: locations
  end

  def show
    render json: Employerlocation.find(params[:id]), status: :ok
  end

  private

  def loc_params
    params.permit(:name, :employer_id)
  end
end
