class EmployeefinancialsController < ApplicationController
  def index
    financials = Employeefinancial.all
    render json: financials, each_serializer: EmployeefinancialsSerializer
  end

  def create
    financial = Employeefinancial.create(fin_params)
    render json: financial
  end

  def show
    financial = Employeefinancial.find(params[:id])
    render json: financial, serializer: EmployeefinancialsSerializer
  end

  private

  def fin_params
    params.permit(:nssf_number, :nhif_number, :kra_pin, :employee_id)
  end
end
