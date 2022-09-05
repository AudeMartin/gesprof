class Teachers::AssignmentsController < ApplicationController
  def show
    @assignment = Assignment.find_by_token(params[:id])
    if @assignement
      @assignement
      @marker = {
        lat: @assignement.school.latitude,
        lng: @assignment.school.longitude
      }
    else
      redirect_to root_url
    end
  end
end
