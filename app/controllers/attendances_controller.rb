class AttendancesController < ApplicationController

  # GET /attendances
  def index
    # Retrieve all time sheets from the database, including the associated employee records
    @attendances = Attendance.includes(:employee).all
    render json: @attendances
  end

  # POST /attendances
  def create
    # Instantiate a new Attendance object with the given parameters
    attendance = Attendance.new(att_params)

    # Calculate the total worked hours and pay for this time sheet
    attendance.calculate_total_worked_hours
    attendance.calculate_pay

    # Save the time sheet to the database
    if attendance.save
      render json: attendance, status: :created
    else
      render json: attendance.errors, status: :unprocessable_entity
    end
  end

  private

  def att_params
    params.require(:attendance).permit(:employee_id, :date, :time_in, :time_out)
  end
end
