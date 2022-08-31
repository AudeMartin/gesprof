class Schools::AssignmentsController < ApplicationController

  def index
  end

  def new
    # @school = current_user.school
    @assignment = Assignment.new
  end

  def create
  end

  def show
  end
end
