class ApplicationsController < ApplicationController
  before_action :correct_application?, only: [:show]

  def show
    @application = Application.find(params[:id])
    if params[:pet_search]
      @pets = Pet.all.search_pet_by_name(params[:pet_search])
    end
  end

  def new
  end

  def create
    application = Application.new(application_params)
    application.user_id = current_user.id
    if application.save
      redirect_to application_path(application.id)
    else 
      flash.now.notice = "Application not created: Required information missing or invalid."
      render :new
    end
  end
  
  def update
    application = Application.find(params[:id])
    if params[:description] == ""
      flash[:failure] = "Enter a valid description"
    else
      application.update(description: params[:description], application_status: "Pending")
    end
    redirect_to application_path(application.id)
  end

  private

  def application_params
    params.permit(:name, :street, :city, :state, :zip_code, :user_id)
  end

  def correct_application?
    @application = Application.find(params[:id])
    render file: "/public/404" unless @application.user_id == current_user.id
  end
end