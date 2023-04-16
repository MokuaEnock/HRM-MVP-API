class EmployeetasksController < ApplicationController
  def create
    tasks = Employeetask.create(task_params)
    render json: tasks
  end

  def index
    render json: tasks, each_serializer: EmployeetaskSerializer
  end

  def show
    task = Employeetask.find(params[:id])
    render json: task, serializer: EmployeetaskSerializer
  end

  private

  def task_params
    params.permit(:employee_id, :name, :description, :start, :end, :status, :priority, :estimated_hours, :actual_hours, :due_date)
  end
end
