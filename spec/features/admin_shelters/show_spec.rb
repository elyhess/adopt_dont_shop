require 'rails_helper'

describe 'As a visitor' do
  describe 'when i visit the admin shelter show page' do
    before :each do
      @shelter1 = Shelter.create!(name: "A", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
      @shelter2 = Shelter.create!(name: "B", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
      @shelter3 = Shelter.create!(name: "C", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)

      @pet1 = @shelter1.pets.create!(sex: :female, name: "k", approximate_age: 3, description: "super cute")
      @pet2 = @shelter2.pets.create!(sex: :female, name: "z", approximate_age: 3, description: "super cute")
      @pet3 = @shelter1.pets.create!(sex: :female, name: "y", approximate_age: 3, description: "super cute")
      @pet4 = @shelter1.pets.create!(sex: :male, name: "x", approximate_age: 3, description: "super cute")
      @user = User.create(username: "admin", password: "admin", role: 1)
      @user1= User.create(username: "x", password: "admin", role: 0)

      @frank = Application.create!(name: "Frank",
                                  street: "2222 6th st.",
                                  city: "Denver",
                                  state: "CO",
                                  zip_code: 80214,
                                  application_status: "Pending",
                                  description: "I want these pets.", user_id: @user1.id)

      @linda = Application.create!(name: "linda",
                                  street: "2222 6th st.",
                                  city: "Denver",
                                  state: "CO",
                                  zip_code: 80214,
                                  application_status: "Approved",
                                  description: "I want these pets.", user_id: @user1.id)

      @app_pet1 = ApplicationPet.create!(application: @linda, pet: @pet1, status: "Approved")
      @app_pet2 = ApplicationPet.create!(application: @linda, pet: @pet2, status: "Approved")
      @app_pet3 = ApplicationPet.create!(application: @frank, pet: @pet3, status: "In Progress")
      @app_pet4 = ApplicationPet.create!(application: @frank, pet: @pet4, status: "In Progress")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'Then I see the shelters attributes' do
      visit admin_shelter_path(@shelter1)

      expect(page).to have_content(@shelter1.address)
      expect(page).to have_content(@shelter1.state)
      expect(page).to have_content(@shelter1.city)
      expect(page).to have_content(@shelter1.zip)
      expect(page).to have_link("#{@shelter1.name}'s Pets")
      expect(page).to have_link("Edit Shelter")
      expect(page).to have_button("Delete Shelter")
    end

    it 'Then I see the shelters statistics' do
      visit admin_shelter_path(@shelter1)

      expect(page).to have_content("Statistics")

      within('#statistics') do
        expect(page).to have_content("Average pet age: #{@shelter1.pets.avg_age}")
        expect(page).to have_content("Available pets: #{@shelter1.pets.adoptable_count}")
        expect(page).to have_content("Adopted pets: #{@shelter1.pets.adopted_count}")
      end
    end

    it 'Then I see the action required section with pets in a pending state' do
      visit admin_shelter_path(@shelter1)

      within('#action-required') do
        expect(page).to have_content(@pet3.name)
        expect(page).to have_content(@pet4.name)
      end
    end
  end
end