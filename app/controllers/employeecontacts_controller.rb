class EmployeecontactsController < ApplicationController
  def index
    contact = Employeecontact.all
    render json: contact
  end

  def create
    contact = Employeecontact.new(cont_params)
    if contact.save
      render json: contact, status: :created
    else
      render json: { errors: contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    contact = Employeecontact.find(params[:id])
    render json: contact
  end

  private

  def cont_params
    params.permit(:employee_id, :phone_number, :email_address, :whatsapp_number)
  end
end
