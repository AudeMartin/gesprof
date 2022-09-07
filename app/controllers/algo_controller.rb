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

    # assignments.each do |assignment|
    #   TeacherMailer.with(teacher: assignment.teacher).teacher_email.deliver_now if assignment.teacher.present?
    # end
    Assignment.archive_old
    
    redirect_back_or_to root_path
  end

  def anim
    @schools = current_user.area.schools
    @end_markers = @schools.select { |school|
      school.assignments.any?
    }.map { |school| { school_id: school.id, lat: school.latitude, lng: school.longitude } }
    @start_markers = []
    @end_markers.each do |marker|
      school = @schools.sample
      @start_markers << { school_id: marker[:school_id], lat: school.latitude, lng: school.longitude }
    end
  end
end
