class DepartmentsController < ApplicationController
  def create
    depts = Department.create(dep_params)
    render json: depts
  end

  def index
    @department = Department.all
    render json: @departments, each_serilizer: DepartmentSerializer
  end

  def show
    render json: Department.find(params[:id]), status: :ok
  end

  private

  def dep_params
    params.permit(:name, :employer_id)
  end
end
