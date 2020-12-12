class ApplicationPetsController < ApplicationController
  def create
    ApplicationPet.create!(application_id: params[:application_id],
                            pet_id: params[:pet_id])
    redirect_to application_path(params[:application_id])
  end
end
