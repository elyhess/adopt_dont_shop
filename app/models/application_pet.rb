class ApplicationPet < ApplicationRecord
  scope :is_approved, -> { where('status = ?', "Approved") }
  scope :is_rejected, -> { where('status = ?', "Rejected") }
  scope :app_pets, -> (app_id) { where(application_id: app_id) }

  belongs_to :application
  belongs_to :pet
  validates_presence_of :status, :application_id, :pet_id
  validates :pet_id, uniqueness: { scope: :application_id }
  

  def self.all_pets_approved?(app_id)
    app_pets(app_id).is_approved.count == app_pets(app_id).count
  end

  def self.any_pets_rejected?(app_id)
    app_pets(app_id).is_rejected.count >= 1
  end

end