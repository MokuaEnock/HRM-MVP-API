class DisciplinariesController < ApplicationController
  def create
    disp = Disciplinary.create(dis_params)
    render json: disp
  end

  def index
    render json: Disciplinary.all, each_serializer: DisciplinarySerializer
  end

  def show
    disp = Disciplinary.find(params[:id])
    render json: disp
  end

  def destroy
    disp = Disciplinary.find(params[:id])
    disp.destroy
    render json: { message: "Record deleted" }
  end

  private

  def dis_params
    params.permit(:employee_id, :name, :date, :description, :verdict)
  end
end
