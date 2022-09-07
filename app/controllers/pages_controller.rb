class PagesController < ApplicationController
  def home
    redirect_to edit_schools_school_path(current_user.school) if current_user&.directeur?
    redirect_to area_schools_path(current_user.area) if current_user&.gestionnaire?
  end
end
