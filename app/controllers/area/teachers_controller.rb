class Area::TeachersController < ApplicationController
  def show
    @assignment = Assignment.find_by_token(params[:token])
    if @assignment
      @marker = {
        lat: @assignment.school.latitude,
        lng: @assignment.school.longitude
      }
    else
      redirect_to root_url
    end
  end
end
