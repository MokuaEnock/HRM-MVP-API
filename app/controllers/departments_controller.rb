class DepartmentsController < ApplicationController
  def create
    depts = Department.create(dep_params)
    render json: depts
  end

  def index
    render json: Department.all
  end

  def show
    @department = Department.find(params[:id])
    render json: @department, serializer: DepartmentSerializer
  end

  private

  def dep_params
    params.permit(:name, :email, :password, :password_confirmation, :employer_id)
  end
end
