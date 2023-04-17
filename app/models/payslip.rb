class Payslip < ApplicationRecord
  after_create :calculate_days_present_and_absent
  after_create :create_rating
  belongs_to :employee
  validate :start_and_end_dates

  def start_and_end_dates
    if start_date.nil? || end_date.nil?
      errors.add(:end_date, "Start date and end date must be present.")
    elsif (end_date - start_date).to_i != 13
      errors.add(:end_date, "The payslip period must be exactly 14 days.")
    end
  end

  def calculate_payslip_period
    (end_date - start_date).to_i + 1
  end

  def calculate_gross_salary
    attendances = Attendance.where(employee_id: employee_id, date: start_date..end_date)
    total_pay = attendances.sum(:total_salary)
  end

  def calculate_nhif_deduction
    case calculate_gross_salary
    when 0..5999
      150
    when 6000..7999
      300
    when 8000..11999
      400
    when 12000..14999
      500
    when 15000..19999
      600
    when 20000..24999
      750
    when 25000..29999
      850
    when 30000..34999
      900
    when 35000..39999
      950
    else
      1000
    end
  end

  def calculate_nssf_deduction
    return 200
  end

  def calculate_taxable_income
    taxable_income = calculate_gross_salary - calculate_nhif_deduction - calculate_nssf_deduction
    return [taxable_income, 0].max
  end

  def calculate_paye
    taxable_income = calculate_taxable_income
    paye = 0

    if taxable_income <= 12298
      paye = 0.1 * taxable_income
    elsif taxable_income <= 23885
      paye = 0.15 * (taxable_income - 12298) + 1229.80
    elsif taxable_income <= 35472
      paye = 0.2 * (taxable_income - 23885) + 3204.80
    elsif taxable_income <= 47059
      paye = 0.25 * (taxable_income - 35472) + 5630.80
    else
      paye = 0.3 * (taxable_income - 47059) + 8963.30
    end

    return paye.round(2)
  end

  def calculate_net_salary
    gross_salary = calculate_gross_salary
    paye = calculate_paye
    nhif = calculate_nhif_deduction
    nssf = calculate_nssf_deduction
    net_salary = gross_salary - paye - nhif - nssf
    return net_salary.round(2)
  end

  def calculate_attendance_data
    attendance_dates = (start_date..end_date).to_a
    attendances = Attendance.where(employee_id: employee_id, date: start_date..end_date)
    attendance_hours = {}
    attendance_pay = {}
    attendance_dates.each do |date|
      attendance_hours[date] = 0
      attendance_pay[date] = 0
    end
    attendances.each do |attendance|
      attendance_hours[attendance.date] = attendance.total_worked_hours
      attendance_pay[attendance.date] = attendance.pay
    end
    attendance_hours = attendance_hours.sort.to_h
    attendance_pay = attendance_pay.sort.to_h
    attendance_data = {
      dates: attendance_hours.keys,
      hours_worked: attendance_hours.values,
      pay: attendance_pay.values,
    }
    return attendance_data
  end

  def calculate_sacco_deduction
    saccos = Employeesacco.where(employee_id: employee_id)
    sacco_contributions = []

    if saccos.present?
      saccos.each do |sacco|
        sacco_amount = sacco.contribution_amount
        sacco_contributions << sacco_amount
      end
    end

    total_sacco_deduction = sacco_contributions.sum
    return total_sacco_deduction
  end

  def calculate_insurance_deduction
    insurance_deduction = 0

    # Retrieve all insurances belonging to employee
    insurances = Employeeinsuarance.where(employee_id: employee_id)

    if insurances.present?
      # Calculate deduction for each insurance and add to total
      insurance_deductions = []
      insurances.each do |insurance|
        insurance_amount = insurance.premium_amount.to_i
        insurance_deductions.push(insurance_amount)
      end
      insurance_deduction = insurance_deductions.sum
    else
      # If no insurances, set deduction to zero
      insurance_deduction = 0
    end

    return insurance_deduction
  end

  def self.last_five_for_employee(employee_id)
    payslips = where(employee_id: employee_id).order(created_at: :desc).limit(5)
    payslips_data = []

    payslips.each do |payslip|
      deductions = {
        nhif: payslip.nhif,
        sacco: payslip.sacco,
        insurance: payslip.insurance,
        nssf: payslip.nssf,
        paye: payslip.paye,
      }

      employee_details = {
        name: payslip.employee.email,
        basic_salary: payslip.employee.employeework.basic_salary,
        payslip_id: payslip.id,
      }

      payslip_period = {
        start_date: payslip.start_date,
        end_date: payslip.end_date,
        payslip_period: payslip.payslip_period,
      }

      week1_dates = (payslip.start_date..(payslip.start_date + 6.days)).to_a
      week2_dates = ((payslip.end_date - 6.days)..payslip.end_date).to_a

      overtime_week1 = Attendance.where(employee_id: employee_id, date: week1_dates)
                                 .pluck(:overtime_pay).sum
      overtime_week2 = Attendance.where(employee_id: employee_id, date: week2_dates)
                                 .pluck(:overtime_pay).sum

      week1_pay = Attendance.where(employee_id: employee_id, date: week1_dates)
        .pluck(:total_salary)

      week2_pay = Attendance.where(employee_id: employee_id, date: week2_dates)
        .pluck(:total_salary)

      weeky_pay = {
        pay_week1: week1_pay.map(&:to_f),
        pay_week2: week2_pay.map(&:to_f),
      }

      employee_pay = {
        net_pay: payslip.net_salary,
        gross_pay: payslip.gross_salary,
      }

      payslips_data << {
        employee_details: employee_details,
        payslip_period: payslip_period,
        week1: {
          start_date: payslip.start_date,
          end_date: (payslip.start_date + 6.days),
          dates: week1_dates,
          overtime_pay: overtime_week1,
        },
        week2: {
          start_date: (payslip.end_date - 6.days),
          end_date: payslip.end_date,
          dates: week2_dates,
          overtime_pay: overtime_week2,
        },
        deductions: deductions,
        employee_pay: employee_pay,
        weekly_pay: weeky_pay,
      }
    end

    payslips_data
  end

  def create_rating
    discipline_score = 100
    attendance_score = 100
    punctuality_score = 100

    # Calculate discipline score
    discipline_count = Discipline.where(employee_id: self.employee_id).where("occurence_date < ?", self.start_date).count
    discipline_score = [100 - (10 * discipline_count), 0].max if discipline_count > 0

    # Calculate attendance score
    weekdays_missed = 0
    total_weekdays = (self.start_date..self.end_date).count { |date| date.on_weekday? }
    current_date = self.start_date
    while current_date <= self.end_date
      attendance = Attendance.find_by(employee_id: self.employee_id, date: current_date)
      if attendance && !attendance.reason.present? && attendance.date.on_weekday?
        weekdays_missed += 1
      end
      current_date += 1.day
    end
    attendance_score = [100 - (weekdays_missed * 10.0 / total_weekdays), 0].max if total_weekdays > 0

    # Calculate punctuality score
    total_hours_worked = Attendance.where(employee_id: self.employee_id, date: self.start_date..self.end_date).sum(:total_worked_hours)
    punctuality_score = if total_hours_worked >= 38
        100
      else
        [100 - ((38 - total_hours_worked) * 10), 0].max
      end

    self.discipline_score = discipline_score
    self.attendance_score = attendance_score
    self.punctuality_score = punctuality_score
    self.rating = (discipline_score * 0.5) + (attendance_score * 0.3) + (punctuality_score * 0.2)
    self.save
  end

  def calculate_days_present_and_absent
    # Calculate total days in the pay period
    total_days = (self.end_date - self.start_date).to_i + 1
    weekdays = (self.start_date..self.end_date).select { |day| (1..5).include?(day.wday) }
    total_weekdays = weekdays.count

    # Calculate days present and absent
    present_dates = self.employee.attendances.where(date: weekdays).pluck(:date).to_set
    days_present = present_dates.count
    days_absent = total_weekdays - days_present

    # Update the Payslip record
    self.update(days_present: days_present, days_absent: days_absent, days_total: total_weekdays)
  end
end
