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
    # attendance.calculate_overtime

    # Save the time sheet to the database
    if attendance.save
      render json: attendance, status: :created
    else
      render json: attendance.errors, status: :unprocessable_entity
    end
  end

  # GET /attendance_summary/:employee_id
  def attendance_summary
    employee = Employee.find(params[:employee_id])
    summary = {}

    # Group the attendances by year and month and calculate the total worked hours and pay for each group
    Attendance.where(employee_id: employee)
      .group_by { |attendance| [attendance.date.year, attendance.date.month] }
      .each do |(year, month), attendances|
      present_days = attendances.count { |attendance| attendance.total_worked_hours > 0 }
      absent_days = month_days(year, month) - attendances.count { |attendance| !attendance.total_worked_hours.zero? || attendance.date.sunday? }
      total_pay = attendances.sum(&:pay)
      summary[year] ||= {}
      summary[year][month] ||= {
        month_name: Date.new(year, month).strftime("%B"),
        present_days: 0,
        absent_days: 0,
        total_pay: 0.0,
      }
      summary[year][month][:present_days] += present_days
      summary[year][month][:absent_days] += absent_days
      summary[year][month][:total_pay] += total_pay
    end

    render json: summary
  end

  private

  def att_params
    params.require(:attendance).permit(:employee_id, :date, :time_in, :time_out)
  end

  def month_days(year, month)
    Date.new(year, month, -1).day
  end
end
