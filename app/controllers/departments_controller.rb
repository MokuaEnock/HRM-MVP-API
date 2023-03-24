class DepartmentsController < ApplicationController
  def create
    depts = Department.create(dep_params)
    render json: depts
  end

  def index
    # @department = Department.all
    render json: Department.all
  end

  def show
    # render json: Department.find(params[:id]), status: :ok
    @department = Department.find(params[:id])
    render json: @department, serializer: DepartmentSerializer
  end

  private

  def dep_params
    params.permit(:name, :employer_id)
  end
end
