class DepartmentdetailsController < ApplicationController
  def create
    details = Departmentdetail.create(dep_params)
    render json: details
  end

  def index
    render json: Departmentdetail.all
  end

  private

  def dep_params
    params.permit(:name, :department_id)
  end
end
