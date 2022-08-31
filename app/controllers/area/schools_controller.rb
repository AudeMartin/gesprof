class Area::SchoolsController < ApplicationController

  def index
    @schools = School.where(area: current_user.area)
  end

  def show
    @schools = School.where(area: current_user.area)
    raise
  end

  private

  def set_school
    @school = School.find(params[:id])
  end
end
