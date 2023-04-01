class AttendancesController < ApplicationController
  # GET /time_sheets
  def index
    # Retrieve all time sheets from the database, including the associated employee records
    @attendances = TimeSheet.includes(:employee).all
    render json: @attendances
  end

  # POST /time_sheets
  def create
    # Instantiate a new TimeSheet object with the given parameters
    @attendance = TimeSheet.new(time_sheet_params)

    # Calculate the total worked hours and pay for this time sheet
    @attendance.calculate_total_worked_hours
    @attendance.calculate_pay

    # Save the time sheet to the database
    if @attendance.save
      render json: @attendance, status: :created
    else
      render json: @attendance.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through
  def time_sheet_params
    params.require(:time_sheet).permit(:employee_id, :date, :time_in, :time_out)
  end
end
