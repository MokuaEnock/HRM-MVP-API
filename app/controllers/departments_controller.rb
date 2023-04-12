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

  def create_multiple
    depts = []
    params[:departments].each do |dept_params|
      dept = Department.create(dept_params)
      depts << dept
    end
    render json: depts
  end

  private

  def dep_params
    params.permit(:name, :email, :password, :password_confirmation, :employer_id)
  end
end
