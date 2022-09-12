class Area::AssignmentsController < ApplicationController
  before_action :set_assignment, if: :user_signed_in?, only: %i[edit update]

  def edit
  end

  def update
    old_assigns = Assignment.where(teacher_id: params[:assignment][:teacher_id]).daily
    old_assigns.update_all(teacher_id: nil, progress: 3)

    @assignment.update(assignment_params)
    TeacherMailer.with(teacher: @assignment.teacher).reassign_email.deliver_now
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
