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
    employee = Employee.find(params[:id])
    attendances = Attendance.where(employee_id: employee)
    summary = {}

    attendances.each do |attendance|
      month = attendance.date.month
      year = attendance.date.year

      # Initialize the summary hash for this month and year if it doesn't exist
      summary[year] ||= {}
      summary[year][month] ||= {
        month_name: attendance.date.strftime("%B"),
        present_days: 0,
        absent_days: 0,
        total_pay: 0.0,
      }

      # Increment the present_days or absent_days count depending on the attendance record
      if attendance.total_worked_hours > 0
        summary[year][month][:present_days] += 1
        summary[year][month][:total_pay] += attendance.pay
      else
        summary[year][month][:absent_days] += 1
      end
    end

    # Loop through each month to record the days the employee was absent except Sundays
    summary.each do |year, months|
      months.each do |month_num, month_data|
        month = Date.new(year, month_num)
        absent_days = 0

        # Loop through each day of the month
        (1..month.end_of_month.day).each do |day|
          date = Date.new(year, month_num, day)

          # Check if the date is a Sunday or if there is an attendance record for this date
          if date.sunday? || attendances.any? { |attendance| attendance.date == date }
            next
          else
            absent_days += 1
          end
        end

        # Record the absent days in the summary
        summary[year][month_num][:absent_days] = absent_days
      end
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
