class AttendancesController < ApplicationController
  def index
    attendance = Attendance.all
    render json: attendance, each_serializer: AttendanceSerializer
  end

  def create
    attendace = Attendance.create(att_params)
    render json: attendace
  end

  def show
    attendace = Attendance.find(params[:id])
    render json: attendace, serializer: AttendanceSerializer
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
    params.permit(:employee_id, :in_time, :out_time, :reason, :timeIn, :timeOut, :date)
  end
end
