class Area::SchoolsController < ApplicationController

  def index
  end

  def show
    @schools = School.where(area: current_user.area)
  end
end
