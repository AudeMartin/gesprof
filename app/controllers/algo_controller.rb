class AlgoController < ApplicationController
  def assign
    @schools = current_user.area.schools
    to_assign = []
    @schools.each do |school|
      if school.assignments.present?
        school.assignments.each do |assignement|
          to_assign << assignement
        end
      end
    end
    assignment_ids = to_assign.map(&:id)
    Assignment.where(id: assignment_ids).assign_all if to_assign.present?
    Assignment.archive_old
    redirect_back_or_to root_path
  end
end
