class EmployeedetailsController < ApplicationController
  def index
    details = Employeedetail.all
    render json: details, each_serializer: EmployeedetailsSerializer
  end

  def show
    details = Employeedetail.find(params[:id])
    render json: details, serializer: EmployeedetailsSerializer
  end

  def create
    detail = Employeedetail.create(det_params)
    render json: detail
  end

  private

  def det_params
    params.permit(:first_name, :second_name, :third_name, :employee_id, :gender, :national_id)
  end
end
