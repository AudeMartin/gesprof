class Area::SchoolsController < ApplicationController
  before_action :set_school, if: :user_signed_in?, only: %i[show]

  def index
    selected_schools = School.where(area: current_user.area)
    case params[:sort]
    when "name"
      @schools = selected_schools.order(params[:sort])
    when "absences"
      @schools = selected_schools.sort_by{|school| school.assignments.where(date: Date.today).size}.reverse
    # when "initial_rate"
    #   @schools = selected_schools.sort_by{|school| school.ratio}.reverse
    when "assignments"
      @schools = selected_schools.sort_by{|school| school.assignments.where(date: Date.today, progress: 2).size}.reverse
    else
      @schools = selected_schools.sort_by{|school| school.ratio}.reverse
    # when "current_rate"
    #   @schools = selected_schools.sort_by{|school| school.assignments.where(date: Date.today).size}.reverse
    end
  end

  def show
    @assignments_confirmed = @school.assignments.where(date: Date.today, progress: "validated")
    @assignments_requests = @school.assignments.where(date: Date.today)
    @initial_ratio = (@assignments_requests.size.fdiv(@school.classes_number) * 100).round(2)
    @new_ratio = (@assignments_confirmed.size.fdiv(@school.classes_number) * 100).round(2)
  end

  private

  def set_school
    @school = School.find(params[:id])
  end

  def query_params

  end
end
