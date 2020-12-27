require 'rails_helper'

describe 'As a visitor' do
  describe 'when i visit the admin shelter index' do
    before :each do
      @shelter1 = Shelter.create!(name: "A", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
      @shelter2 = Shelter.create!(name: "B", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
      @shelter3 = Shelter.create!(name: "C", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)

      @pet1 = @shelter1.pets.create!(sex: :female, name: "k", approximate_age: 3, description: "super cute")
      @pet2 = @shelter2.pets.create!(sex: :female, name: "z", approximate_age: 3, description: "super cute")
      @pet3 = @shelter2.pets.create!(sex: :female, name: "y", approximate_age: 3, description: "super cute")
      @pet4 = @shelter3.pets.create!(sex: :male, name: "x", approximate_age: 3, description: "super cute")
      
      @user = User.create(username: "admin_name_something", password: "admin", role: 1)
      @user1 = User.create(username: "default_name_something", password: "admin", role: 0)

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
      @app_pet3 = ApplicationPet.create!(application: @frank, pet: @pet3, status: "Pending")
      @app_pet4 = ApplicationPet.create!(application: @frank, pet: @pet4, status: "Pending")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'Then I see all Shelters in the system listed in reverse alphabetical order by name' do
      visit admin_shelters_path

      within "#shelter-#{@shelter3.id}" do
        expect(page).to have_content(@shelter3.name)
      end

      within "#shelter-#{@shelter2.id}" do
        expect(page).to have_content(@shelter2.name)
      end

      within "#shelter-#{@shelter1.id}" do
        expect(page).to have_content(@shelter1.name)
      end
    end

    it 'it shows a list of shelters with pending applications' do
      visit admin_shelters_path

      within "#shelter-pending-#{@shelter2.id}" do
        expect(page).to have_content(@shelter2.name)
      end

      within "#shelter-pending-#{@shelter3.id}" do
        expect(page).to have_content(@shelter3.name)
      end

    end
  end
end