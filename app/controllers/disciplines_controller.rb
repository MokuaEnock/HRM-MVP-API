class DisciplinesController < ApplicationController
  def create
    disp = Discipline.create(dis_params)
    render json: disp
  end

  def index
    render json: Discipline.all, each_serializer: DisciplineSerializer
  end

  def show
    disp = Discipline.find(params[:id])
    render json: disp
  end

  def destroy
    disp = Discipline.find(params[:id])
    disp.destroy
    render json: { message: "Record deleted" }
  end

  private

  def dis_params
    params.permit(:employee_id, :name, :date, :description, :verdict, :type, :verdict, :employee_statement, :reason, :action_taken, :verbal_warning, :written_warning, :suspension, :termination, :suspension_start, :suspension_end, :suspension_reason)
  end
end
