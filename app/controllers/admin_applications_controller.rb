class AdminApplicationsController < ApplicationController
  before_action :require_admin

  def show
    @application = Application.find(params[:id])
  end

  private
  
  def require_admin
    render file: "/public/404" unless current_admin?
  end
end