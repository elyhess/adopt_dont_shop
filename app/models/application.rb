class Application < ApplicationRecord
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets
  accepts_nested_attributes_for :pets

  validates_presence_of :name
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip_code
  validates :zip_code, zipcode: { country_code: :us }
  validates_presence_of :description, on: :update

  def in_progress?
    application_status == "In Progress"
  end

  def pending?
    application_status == "Pending"
  end

  def approved?
    application_status == "Approved"
  end

  def rejected?
    application_status == "Rejected"
  end

  def has_pets_selected?
    pets.count >= 1
  end

  def pet_status(pet_id)
    application_pets.find_by(pet_id: pet_id).status
  end

  def approval
    pets.make_adopted
    update(application_status: "Approved")
  end
  
  def rejection
    update(application_status: "Rejected")
  end

end
