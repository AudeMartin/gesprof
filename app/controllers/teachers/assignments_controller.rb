class Teachers::AssignmentsController < ApplicationController
  def show
    @assignment = Assignment.find_by_token(params[:id])
    if @assignement @assignement || redirect_to root_url
  end
end
