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

  private

  def employer_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
