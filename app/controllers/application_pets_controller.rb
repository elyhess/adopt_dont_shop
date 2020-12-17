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
    application_pet = ApplicationPet.where(application_id: params[:application_id], pet_id: params[:pet_id])
    approve_or_reject(application, application_pet, params[:status])
    redirect_to admin_application_path(application)
  end

end

private

def approve_or_reject(application, application_pet, status)
  if status == "Approved"
    application_pet.update(status: "Approved")
    if ApplicationPet.all_pets_approved?(application.id)
      application.approval
    end
  elsif status == "Rejected" 
    application_pet.update(status: "Rejected")
    if ApplicationPet.any_pets_rejected?(application.id)
      application.rejection
    end
  end
end