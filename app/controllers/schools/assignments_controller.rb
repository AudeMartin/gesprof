class Schools::AssignmentsController < ApplicationController

  def index
    @school = current_user.school
    @assignments = Assignment.where(school: @school).order(:date)
  end

  def new
  end

  def create
  end

  def show
  end
end
