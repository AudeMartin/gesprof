class Area::AssignmentsController < ApplicationController

  before_action :set_assignment, if: :user_signed_in?, only: %i[edit, update]

  def edit
  end

  def update
    @assignment.update(assignment_params)
    redirect_to area_school_path(@assignment.school)
  end

  private

  def assignment_params
    params.require(:assignment).permit(:teacher_id, :school_id)
  end

  def set_assignment
    @assignment = Assignment.find(params[:id])
  end
end
