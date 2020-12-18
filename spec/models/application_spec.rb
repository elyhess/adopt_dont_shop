require "rails_helper"

describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:application_pets).dependent(:destroy) }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip_code }
    it { is_expected.to validate_presence_of(:description).on(:update) }
  end

  describe "instance methods" do
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
                                  application_status: "Approved",
                                  description: "I want these pets.")

      @frank = Application.create!(name: "Abby",
                                   street: "2222 6th st.",
                                   city: "Denver",
                                   state: "CO",
                                   zip_code: 80214,
                                   application_status: "Rejected",
                                   description: "I want these pets.")

      @poe = Application.create!(name: "Poe",
                                 street: "666 18th st.",
                                 city: "Lakewood",
                                 state: "CO",
                                 zip_code: 80511,
                                 application_status: "Pending",
                                 description: "I want these pets.")

      @bob = Application.create!(name: "bob",
                                 street: "1231 6th st.",
                                 city: "Louisville",
                                 state: "CO",
                                 zip_code: 82111,
                                 application_status: "In Progress",
                                 description: "I want these pets.")

      ApplicationPet.create!(application: @abby, pet: @pet1, status: "Approved")
      ApplicationPet.create!(application: @abby, pet: @pet2, status: "Approved")
      ApplicationPet.create!(application: @abby, pet: @pet3, status: "Approved")

      ApplicationPet.create!(application: @frank, pet: @pet5, status: "Approved")
      ApplicationPet.create!(application: @frank, pet: @pet6, status: "Approved")
      ApplicationPet.create!(application: @frank, pet: @pet7, status: "Rejected")
    end
    it "#in_progress?" do
      expect(@bob.in_progress?).to eq(true)
      expect(@poe.in_progress?).to eq(false)
    end

    it "#pending?" do
      expect(@bob.pending?).to eq(false)
      expect(@poe.pending?).to eq(true)
    end

    it "#approved?" do
      expect(@abby.approved?).to eq(true)
      expect(@poe.approved?).to eq(false)
    end

    it "#rejected?" do
      expect(@frank.rejected?).to eq(true)
      expect(@abby.rejected?).to eq(false)
    end

    it "#has_pets_selected" do
      expect(@abby.has_pets_selected?).to eq(true)
      expect(@poe.has_pets_selected?).to eq(false)
    end

    it "#pet_status" do
      expect(@abby.pet_status(@pet1.id)).to eq("Approved")
      expect(@frank.pet_status(@pet7.id)).to eq("Rejected")
    end

    it '#approval' do
      @abby.approval
      expect(@pet1.reload.adoptable).to eq(false)
      expect(@pet2.reload.adoptable).to eq(false)
      expect(@pet3.reload.adoptable).to eq(false)
    end

    it '#rejection' do
      @abby.rejection
      expect(@abby.application_status).to eq("Rejected")
    end
  end
end
