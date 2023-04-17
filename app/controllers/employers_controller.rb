class EmployersController < ApplicationController
  def index
    render json: Employer.all
  end

  def create
    employer = Employer.new(employer_params)
    if employer.save
      render json: { id: employer.id }
    else
      render json: { errors: employer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @employer = Employer.find(params[:id])
    render json: @employer, serializer: EmployerSerializer
  end

  def total_employees
    employer = Employer.find(params[:id])
    total_employees = 0

    employer.departments.each do |department|
      total_employees += department.employees.count
    end

    render json: { total_employees: total_employees }
  end

  private

  def employer_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
