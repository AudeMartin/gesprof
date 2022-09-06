class Area::AssignmentsController < ApplicationController

  before_action :set_assignment, if: :user_signed_in?, only: %i[edit update]

  def edit
  end

  def update
    @assignment.progress = params[:assignment][:teacher_id].empty? ? 1 : 2
    @assignment.update(assignment_params)
    respond_to do |format|
      format.html { redirect_to area_school_path(params[:school_id]) }
      format.json {
        render json: {
          teacher: @assignment.teacher,
          ratio: @assignment.school.init_ratio
        }
      }
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:teacher_id)
  end

  def set_assignment
    @assignment = Assignment.find(params[:id])
  end
end
