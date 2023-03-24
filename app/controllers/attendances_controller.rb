class AttendancesController < ApplicationController
  def index
    render json: {}
  end

  def create
    attendace = Attenndance.create(att_params)
    render json: attendace
  end

  def show
    attendace = Attendance.find(params[:id])
    render json: attendace
  end

  def update
    attendence = Attendance.find(params[:id])

    if attendence.update(user_params)
      render json: { message: "User updated successfully" }, status: :ok
    else
      render json: { errors: attendence.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    attendance = Attendance.find(params[:id])
    attendance.destroy
    render json: { message: "Attendance deleted" }, status: :ok
  end

  private

  def att_params
    params.permit(:date, :department_id, :employee_id, :time_in, :time_out, :is_present, :is_late, :reason)
  end
end
