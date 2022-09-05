require 'json'

class Area::SchoolsController < ApplicationController
  before_action :set_school, if: :user_signed_in?, only: %i[show]

  def index
    selected_schools = School.where(area: current_user.area)
    case params[:sort]
    when "name"
      @schools = selected_schools.order(params[:sort])
    when "absences"
      @schools = selected_schools.sort_by { |school| [-school.absences, -school.ratio, -school.init_ratio] }
    when "initial_rate"
      @schools = selected_schools.sort_by { |school| [-school.init_ratio, -school.ratio] }
    when "assignments"
      @schools = selected_schools.sort_by { |school| [-school.assignments.where(date: Date.today, progress: 2).size, -school.ratio, -school.init_ratio] }
    else
      @schools = selected_schools.sort_by { |school| [-school.ratio, -school.init_ratio] }
    end
  end

  def show
    @assignments_refused = @school.assignments.where(date: Date.today, progress: "pending")
    @assignments_requests = @school.assignments.where(date: Date.today)
    @initial_ratio = (@assignments_requests.size.fdiv(@school.classes_number) * 100).round(2)
    @new_ratio = (@assignments_refused.size.fdiv(@school.classes_number) * 100).round(2)
    @teachers_assigned_ids = Assignment.includes(:school).where(
      school: current_user.area.schools,
      progress: 2,
      date: Date.today
    ).map(&:teacher_id)
    @teachers_assigned = Teacher.where(id: @teachers_assigned_ids)
  end

  private

  def set_school
    @school = School.find(params[:id])
  end
end
