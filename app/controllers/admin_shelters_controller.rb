class AdminSheltersController < ApplicationController
  before_action :require_admin

  def index
    @shelters = Shelter.reverse_alphabetical
    @pending_shelters = Shelter.pending_applications
  end

  def show
    @shelter = Shelter.name_address(params[:id])
  end

  private

  def require_admin
    render file: "/public/404" unless current_admin?
  end

end