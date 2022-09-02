class Schools::SchoolsController < ApplicationController
  def edit
    @school = School.find(params[:id])
    # @assignments_of_the_day = @school.assignments.where(date: Date.today)
    @assignment = @school.assignments.new
  end

  def update
    @school = School.find(params[:id])
    if @school.update(school_params)
      redirect_to schools_school_path(@school)
    else
      render :edit
    end
  end

  private

  def school_params
    params.require(:school).permit(assignments_attributes: [:id, :_destroy, :teacher_message, :area_message, :date])
  end
end
