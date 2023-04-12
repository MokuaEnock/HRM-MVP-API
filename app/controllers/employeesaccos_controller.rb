class EmployeesaccosController < ApplicationController
  def create
    sacco = Employeesacco.create(sacco_params)
    render json: sacco
  end

  def destroy
    sacco = Employeesacco.find_by(params[:id])
    sacco.destroy

    render json: sacco
  end

  def index
    render json: Employeesacco.all
  end

  def show
    sacco = Employeesacco.find_by(params[:id])
    render json: sacco
  end

  private

  def sacco_params
    params.permit(:name, :registration_number, :bank_name, :bank_branch, :bank_account_name, :bank_account_number, :membership_number, :contribution_amount, :start_date, :end_date)
  end
end
