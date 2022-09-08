class Area::AssignmentsController < ApplicationController
  before_action :set_assignment, if: :user_signed_in?, only: %i[edit update]

  def edit
  end

  def update
    old_assign = Assignment.find_by(teacher_id: params["assignment"]["teacher_id"])
    if old_assign.present?
      old_assign.teacher_id = nil
      old_assign.save
    end
    progress = params["assignment"]["teacher_id"].empty? ? 1 : 2
    @assignment.update_column(:progress, progress)

    @assignment.update(assignment_params)
    respond_to do |format|
      format.html { redirect_to area_school_path(params[:school_id]) }
      format.json {
        render json: {
          teacher: @assignment.teacher,
          ratio: @assignment.school.ratio,
          rank: @assignment.school.rank(@assignment.school.ratio)
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
