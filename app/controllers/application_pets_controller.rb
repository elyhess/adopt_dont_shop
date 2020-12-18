class ApplicationPetsController < ApplicationController

  def create
    application_pet = ApplicationPet.new(application_id: params[:application_id], pet_id: params[:pet_id])
    if application_pet.save
    else
      flash[:notice] = "You've already added this pet."
    end
    redirect_to application_path(params[:application_id])
  end

  def update
    application = Application.find(params[:application_id])
    application_pets = ApplicationPet.where(application_id: params[:application_id])
    application_pets.approve_or_reject(application, params)
    redirect_to admin_application_path(application)
  end

end