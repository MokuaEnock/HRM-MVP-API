class PayslipsController < ApplicationController
  def index
  end

  def create
  end

  def show
  end

  private

  def pay_params
    params.permit(:employee_id, :start_date, :end_date)
  end
end
