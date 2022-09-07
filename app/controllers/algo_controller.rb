class AlgoController < ApplicationController
  def assign
    @schools = current_user.area.schools
    to_assigns = []
    @schools.each do |school|
      if school.assignments.present?
        school.assignments.each do |assignment|
          to_assigns << assignment if assignment.date == Date.today
        end
      end
    end
    assignment_ids = to_assigns.map(&:id)
    assignments = Assignment.where(id: assignment_ids)
    assignments.assign_all
    assignments.each do |assignment|
      TeacherMailer.with(teacher: assignment.teacher).teacher_email.deliver_now if assignment.teacher.any?
    end
    #Assignment.archive_old
    redirect_back_or_to root_path
  end

  def anim
    @schools = current_user.area.schools
    @end_markers = []
    @start_markers = []
    schools_target = []
    @schools.each do |school|
      schools_target << school if school.assignments.present?
    end
    schools_target.each do |school|
      @end_markers << [school.id, school.latitude, school.longitude]
      start_school = school.assignements.first.teacher.school
      @start_markers << [school.id, start_school.latitude, start_school.longitude]
    end
  end
end
