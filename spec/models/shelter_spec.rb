require "rails_helper"

describe Shelter, type: :model do
  describe "relationships" do
    it { should have_many(:pets).dependent(:destroy) }
  end

  describe "Class Methods" do
    before :each do
      @shelter1 = Shelter.create!(name: "A", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
      @shelter2 = Shelter.create!(name: "B", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
      @shelter3 = Shelter.create!(name: "C", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
    end

    it ".reverse_alphabetical" do
      expect(Shelter.reverse_alphabetical).to eq([@shelter3, @shelter2, @shelter1])
    end

    it ".name_address" do
      expect(Shelter.name_address(@shelter1.id)).to eq(@shelter1)
    end

    it ".pending_applications" do
      shelter = Shelter.create!(name: "x", address: "123 Adoption Ln.", city: "Denver", state: "CO", zip: "80222")
      shelter2 = Shelter.create!(name: "y", address: "123 Adoption Ln.", city: "Denver", state: "CO", zip: "80222")

      pet1 = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: "super cute")
      pet2 = shelter2.pets.create!(sex: :female, name: "Floppy", approximate_age: 3, description: "super cute")
      pet3 = shelter2.pets.create!(sex: :female, name: "Borko", approximate_age: 3, description: "super cute")

      user1= User.create(username: "x", password: "admin", role: 0)

      frank = Application.create!(name: "Frank",
                                  street: "2222 6th st.",
                                  city: "Denver",
                                  state: "CO",
                                  zip_code: 80214,
                                  application_status: "Pending",
                                  description: "I want these pets.", user_id: user1.id)

      linda = Application.create!(name: "linda",
                                  street: "2222 6th st.",
                                  city: "Denver",
                                  state: "CO",
                                  zip_code: 80214,
                                  application_status: "Pending",
                                  description: "I want these pets.", user_id: user1.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
      app_pet1 = ApplicationPet.create!(application: linda, pet: pet1, status: "Pending")
      app_pet2 = ApplicationPet.create!(application: linda, pet: pet2, status: "Pending")
      app_pet3 = ApplicationPet.create!(application: frank, pet: pet3, status: "Pending")

      expect(Shelter.pending_applications).to eq([shelter, shelter2])
    end
  end
end
