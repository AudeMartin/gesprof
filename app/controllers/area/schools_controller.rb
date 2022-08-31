class Area::SchoolsController < ApplicationController

  def index
    @schools = School.where(area: current_user.area)
  end

  def show
    @schools = School.where(area: current_user.area)
  end
end
