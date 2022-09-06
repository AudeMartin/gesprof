class PagesController < ApplicationController
  def home
    redirect_to edit_schools_school_path(current_user.school) if current_user&.directeur?
  end
end
