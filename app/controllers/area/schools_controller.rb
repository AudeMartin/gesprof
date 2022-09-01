class Area::SchoolsController < ApplicationController
  before_action :set_school, if: :user_signed_in?, only: %i[show]

  def index
    selected_schools = School.where(area: current_user.area)
    case params[:sort]
    when "name"
      @schools = selected_schools.order(params[:sort])
    when "absences"
      @schools = selected_schools.sort_by(&:absences).reverse
    # when "initial_rate"
    #   @schools = selected_schools.sort_by{|school| school.ratio}.reverse
    when "assignments"
      @schools = selected_schools.sort_by{|school| school.assignments.where(date: Date.today, progress: 2).size}.reverse
    else
      @schools = selected_schools.sort_by(&:ratio).reverse
    # when "current_rate"
    #   @schools = selected_schools.sort_by{|school| school.assignments.where(date: Date.today).size}.reverse
    end
  end

  def show
    @assignments_refused = @school.assignments.where(date: Date.today, progress: "pending")
    @assignments_requests = @school.assignments.where(date: Date.today)
    @initial_ratio = (@assignments_requests.size.fdiv(@school.classes_number) * 100).round(2)
    @new_ratio = (@assignments_refused.size.fdiv(@school.classes_number) * 100).round(2)
    # @schools_ids = Assignment.includes(:school).where(
    #   school: current_user.area.schools,
    #   progress: 1,
    #   date: Date.today
    # ).map(&:school_id)
    # @schools_area_requests = School.where(id: @schools_ids)
  end

  private

  def set_school
    @school = School.find(params[:id])
  end

  def query_params
  end
end
