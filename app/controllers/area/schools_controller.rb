require 'json'

class Area::SchoolsController < ApplicationController
  before_action :set_school, if: :user_signed_in?, only: %i[show]

  def index
    if params[:search].present?
      @schools = params[:search].split(',').map {|el| School.find(el)}
      respond_to do |format|
        format.html
        format.text { render partial: "area/schools/table", locals: { schools: @schools }, formats: [:html] }
      end
    elsif params[:schools].present?
      selected_schools = School.where(id: params[:schools])
      sort(selected_schools)
    else
      selected_schools = School.where(area: current_user.area)
      sort(selected_schools)
    end
  end

  def show
    @assignments_pending = @school.assigns_pending
    @assignments_requests = @school.today_assigns

    @teachers_assigned_ids = Assignment.teachers_assigned(current_user).map(&:teacher_id)
    @teachers_assigned = Teacher.where(id: @teachers_assigned_ids)
    @assignments_validated = Assignment.validated(current_user)
    @assignments_confirmed_schools_ids = @assignments_validated.map(&:school_id)
    @schools_filled = School.where(id: @assignments_confirmed_schools_ids)
  end

  private

  def sort(schools)
    case params[:sort]
    when "name"
      @schools = schools.order(params[:sort])
    when "absences"
      @schools = schools.sort_by { |school| [-school.absences, -school.ratio, -school.init_ratio] }
    when "initial_rate"
      @schools = schools.sort_by { |school| [-school.init_ratio, -school.ratio] }
    when "assignments"
      @schools = schools.sort_by { |school| [-school.assignments.where(date: Date.today, progress: 2).size, -school.ratio, -school.init_ratio] }
    else
      @schools = schools.sort_by { |school| [-school.ratio, -school.init_ratio] }
    end
  end

  def set_school
    @school = School.find(params[:id])
  end
end
