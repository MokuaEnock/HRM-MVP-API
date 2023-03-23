class DepartmentsController < ApplicationController
  def create
    depts = Department.create(dep_params)
    render json: depts
  end

  def index
    render json: Department.all
  end

  def show
    render json: Department.find(params[:id]), status: :ok
  end

  private

  def dep_params
    permit.params(:name, :employer_id)
  end
end
