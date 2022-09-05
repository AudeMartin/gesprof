class AlgoController < ApplicationController
  def assign
    @schools = current_user.area.schools
    to_assigns = []
    @schools.each do |school|
      if school.assignments.present?
        school.assignments.each do |assignement|
          to_assigns << assignement
        end
      end
    end
    assignment_ids = to_assigns.map(&:id)
    assignments = Assignment.where(id: assignment_ids)
    assignments.assign_all
    assignments.each do |assignment|
      TeacherMailer.with(teacher: assignment.teacher).teacher_email.deliver_later
    end
    Assignment.archive_old
    redirect_back_or_to root_path
  end
end
