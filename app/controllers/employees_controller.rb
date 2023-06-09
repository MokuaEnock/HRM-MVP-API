class EmployeesController < ApplicationController
  def index
    employees = Employee.all
    render json: employees, each_serializer: EmployeeSerializer
  end

  def create
    employee = Employee.new(employee_params)
    if employee.save
      render json: { id: employee.id, employee: employee }, status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @employee = Employee.find(params[:id])
    render json: @employee, serializer: EmployeeSerializer
  end

  def create_multiple
    result = []
    params["_json"].each do |item|
      department = Department.find_by(department_number: item[:department])

      if department.present?
        departmentId = department.id

        # Create employee
        employee = Employee.create(
          department_id: departmentId,
          email: item[:email_address],
          employee_number: item[:employee_number],
          password: item[:email_address],
          password_confirmation: item[:email_address],
        )

        if employee.valid?
          employeeId = employee.id
          # Create associated records
          Employeebank.create(
            employee_id: employeeId,
            bank_name: item[:bank_name],
            branch_name: item[:branch_name],
            account_name: item[:account_name],
            bank_code: item[:bank_code],
            branch_code: item[:branch_code],
          )

          Employeecontact.create(
            employee_id: employeeId,
            phone_number: item[:phone_number],
            email_address: item[:email_address],
            whatsapp_number: item[:whatsapp_number],
          )

          Employeedetail.create(
            employee_id: employeeId,
            first_name: item[:first_name],
            second_name: item[:second_name],
            third_name: item[:third_name],
            gender: item[:gender],
            national_id: item[:national_id],
          )

          Employeefinancial.create(
            employee_id: employeeId,
            nssf_number: item[:nssf_number],
            nhif_number: item[:nhif_number],
            kra_pin: item[:kra_pin],
          )

          Employeeinsuarance.create(
            employee_id: employeeId,
            name: item[:insurance_company_name],
            registration_number: item[:insurance_registration_number],
            bank_name: item[:insurance_company_bank_name],
            bank_branch: item[:insurance_bank_branch],
            bank_account_number: item[:insurance_company_bank_account_number],
            bank_account_name: item[:insurance_company_bank_account_name],
            premium_type: item[:premium_type],
            policy_number: item[:insurance_policy_number],
            premium_amount: item[:Insurance_premium_amount],
            start_date: item[:contribution_start_date],
            end_date: item[:contribution_end_date],
          )

          Employeelocation.create(
            employee_id: employeeId,
            country: item[:country],
            county: item[:county],
            subcounty: item[:sub_county],
            location: item[:location],
          )

          Employeesacco.create(
            employee_id: employeeId,
            name: item[:Sacco_name],
            registration_number: item[:sacco_registration_number],
            bank_name: item[:sacco_bank_name],
            bank_branch: item[:sacco_bank_branch],
            bank_account_number: item[:sacco_bank_account_number],
            bank_account_name: item[:sacco_bank_account_name],
            membership_number: item[:sacco_membership_number],
            contribution_amount: item[:sacco_contribution_amount],
            start_date: item[:sacco_contibution_start_date],
            end_date: item[:sacco_contibution_end_date],
          )

          # Add the created employee's employer id to the result array
          result << { employerId: department.employer_id }
        else
          result << { errors: employee.errors.full_messages }
        end
      else
        result << { errors: "Department not found: #{item[:department]}" }
      end
    end

    render json: result
  end

  def average_rating
    employee = Employee.find(params[:id])
    payslips = employee.payslips
    rating_sum = payslips.sum(:rating)
    average_rating = payslips.count > 0 ? rating_sum.to_f / payslips.count : 0

    render json: { average_rating: average_rating }
  end

  private

  def employee_params
    params.permit(:department_id, :email, :employee_number, :password, :password_confirmation)
  end
end
