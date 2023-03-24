class EmployersController < ApplicationController
  def index
    render json: Employer.all
  end

  def create
    employer = Employer.create(employer_params)
    render json: { id: employer.id }
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
