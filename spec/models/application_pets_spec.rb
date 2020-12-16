require "rails_helper"

describe ApplicationPet, type: :model do
  describe "relationships" do
    it { should belong_to :pet }
    it { should belong_to :application }
  end

  describe "validations" do
    it { should validate_presence_of :application_id }
    it { should validate_presence_of :pet_id }
    it { should validate_presence_of :status }
  end

  describe "class methods" do
    before :each do
      @shelter = Shelter.create!(name: "Pet Rescue", address: "123 Adoption Ln.", city: "Denver", state: "CO", zip: "80222")
      @pet1 = @shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: "super cute")
      @pet2 = @shelter.pets.create!(sex: :female, name: "Floppy", approximate_age: 3, description: "super cute")
      @pet3 = @shelter.pets.create!(sex: :female, name: "Borko", approximate_age: 3, description: "super cute")

      @pet5 = @shelter.pets.create!(sex: :female, name: "lena", approximate_age: 6, description: "sort of cute")
      @pet6 = @shelter.pets.create!(sex: :male, name: "ed", approximate_age: 1, description: "scruffy cute")
      @pet7 = @shelter.pets.create!(sex: :female, name: "fark", approximate_age: 2, description: "mega cute")

      @abby = Application.create!(name: "Abby",
                                 street: "2222 6th st.",
                                 city: "Denver",
                                 state: "CO",
                                 zip_code: 80214,
                                 application_status: "Pending",
                                 description: "I want these pets.")

      @frank = Application.create!(name: "Abby",
                                  street: "2222 6th st.",
                                  city: "Denver",
                                  state: "CO",
                                  zip_code: 80214,
                                  application_status: "Pending",
                                  description: "I want these pets.")

      ApplicationPet.create!(application: @abby, pet: @pet1, status: "Approved")
      ApplicationPet.create!(application: @abby, pet: @pet2, status: "Approved")
      ApplicationPet.create!(application: @abby, pet: @pet3, status: "Approved")

      ApplicationPet.create!(application: @frank, pet: @pet5, status: "Approved")
      ApplicationPet.create!(application: @frank, pet: @pet6, status: "Approved")
      ApplicationPet.create!(application: @frank, pet: @pet7, status: "Rejected")
    end
    it ".all_pets_approved?" do
      expect(ApplicationPet.all_pets_approved?(@abby.id)).to eq(true)
      expect(ApplicationPet.all_pets_approved?(@frank.id)).to eq(false)
    end

    it '.any_pets_rejected?' do
      expect(ApplicationPet.any_pets_rejected?(@abby.id)).to eq(false)
      expect(ApplicationPet.any_pets_rejected?(@frank.id)).to eq(true)
    end
  end
end
