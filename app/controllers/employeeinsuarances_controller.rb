class EmployeeinsuarancesController < ApplicationController
  def index
    insurance = Employeeinsuarance.all
    render json: insurance
  end

  def create
    insurance = Employeeinsuarance.new(ins_params)
    if employee.save
      render json: insurance, status: :created
    else
      render json: { errors: insurance.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    insurance = Employeeinsuarance.find(params[:id])
    render json: insurance
  end

  private

  def employee_params
    params.permit(:employee_id, :name, :registration_number, :bank_name, :bank_branch, :bank_account_number, :bank_account_name, :premium_type, :policy_number, :premium_amount, :start_date, :end_date)
  end
end
