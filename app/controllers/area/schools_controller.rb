class Area::SchoolsController < ApplicationController
  before_action :set_school, if: :user_signed_in?, only: %i[show]

  def index
    @schools = School.where(area: current_user.area)
  end

  def show
    @assignments_confirmed = @school.assignments.where(date: Date.today, progress: "validated")
    @assignments_requests = @school.assignments.where(date: Date.today)
    @schools_area_requests = School.where(id: Assignment.where(
      school: current_user.area.schools,
      progress: ['pending'],
      date: Date.today
    ))
    @initial_ratio = (@assignments_requests.size.fdiv(@school.classes_number) * 100).round(2)
    @new_ratio = (@assignments_confirmed.size.fdiv(@school.classes_number) * 100).round(2)
  end

  private

  def set_school
    @school = School.find(params[:id])
  end
end
