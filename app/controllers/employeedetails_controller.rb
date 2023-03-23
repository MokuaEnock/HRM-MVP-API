class EmployeedetailsController < ApplicationController
  def create
    details = Employeedetail.create(det_params)
    render json: details
  end

  def index
    render json: Employeedetail.all
  end

  private

  def det_params
    params.permit(:name, :employee_id)
  end
end
