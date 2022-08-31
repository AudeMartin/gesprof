class Area::AssignmentsController < ApplicationController

  before_action :set_assignment, if: :user_signed_in?, only: %i[edit]

  def edit
  end

  def update
  end

  private

  def set_assignment
    @assignment.find(params[:id])
  end
end
