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
    @assignments_validated = Assignment.validated(current_user)
    @assignments_confirmed_schools_ids = @assignments_validated.map(&:school_id)

    @schools_filled = School.where(id: @assignments_confirmed_schools_ids)
    @school_validated_assign = Assignment.school_validated_assign(@school.id)
    @schools = current_user.area.schools

    @teachers_assigned_ids = Assignment.teachers_assigned(current_user).map(&:teacher_id)
    @teachers_assigned = Teacher.where(id: @teachers_assigned_ids)
    @area_teachers = status(@school.area)

    @schools_teachers_any = Teacher.teacher_present(current_user)

    @marker_school = @school
    @markers = @schools_teachers_any.map do |school| {
      id: school.id,
      latitude: school.latitude,
      longitude: school.longitude,
      info_window: render_to_string(partial: "info_window", locals: { school: school })
    }
    end
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

  def status(area)
  area.teachers.map do |teacher|
    assignment = teacher.assignments.where(date: Date.today).first
    if assignment
      icon = '<i class="fa-solid fa-do-not-enter"></i>'
      # icon = '<i class="fa-solid fa-do-not-enter"></i>'
    else
      icon = '<i class="fa-thin fa-calendar-check"></i>'
      # icon = '<i class="fa-thin fa-calendar-check"></i>'
    end
    "#{teacher.name} - #{icon.html_safe}"
    end
  end


end



# def status(area)
#   area.teachers.map do |teacher|
#     assignment = teacher.assignments.where(date: Date.today).first
#     if assignment
#       teacher.name = "#{teacher.name} - affecté à #{assignment.school.name}"
#     else
#       teacher.name = "#{teacher.name} - disponible"
#     end
#   end
# end
