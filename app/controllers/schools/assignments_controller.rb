class Schools::AssignmentsController < ApplicationController

  def index
    @school = current_user.school
    @assignments = Assignment.where(school: @school).order(:date).reverse
  end

  def new
  end

  def create
  end

  def show
  end
end
