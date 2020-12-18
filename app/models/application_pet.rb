class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet
  validates_presence_of :status, :application_id, :pet_id
  validates :pet_id, uniqueness: { scope: :application_id }
  
  scope :is_approved, -> { where('status = ?', "Approved") }
  scope :is_rejected, -> { where('status = ?', "Rejected") }
  scope :find_application_pet, -> (app_id, pet_id) { where(application_id: app_id, pet_id: pet_id) }

  def self.all_pets_approved?
    is_approved.count == self.count
  end

  def self.any_pets_rejected?(app_id)
    is_rejected.count >= 1
  end

  def self.approve_or_reject(application, params)
    if params[:status] == "Approved"
      find_application_pet(params[:application_id], params[:pet_id]).update(status: "Approved")
      if self.all_pets_approved?
        application.approval
      end
    elsif params[:status] == "Rejected" 
      find_application_pet(params[:application_id], params[:pet_id]).update(status: "Rejected")
      if self.any_pets_rejected?
        application.rejection
      end
    end
  end

end