class EmployersController < ApplicationController
  def index
    render json: Employer.all
  end

  def create
    employer = Employer.create(employer_params)
    render json: employer
  end

  private

  def employer_params
    params.permit(:name)
  end
end
