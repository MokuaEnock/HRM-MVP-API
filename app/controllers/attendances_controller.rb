class AttendancesController < ApplicationController
  before_action :set_employee
  before_action :set_attendance, only: [:show, :update, :destroy]

  def index
    @attendance = @employee.attendance.all
    render json: @attendance
  end

  def create
    @attendance = @employee
  end

  def show
    render json: @attendance
  end

  def update
  end

  def destroy
    @attendance.destroy
  end

  private

  def set_employee
    @employee = Employee.find(params[:employee_id])
  end

  def set_attendance
    @attendance = @employee.attendances.find(params[:id])
  end

  def att_params
    params.permit(:date, :department_id, :employee_id, :time_in, :time_out, :is_present, :is_late, :reason)
  end
end
