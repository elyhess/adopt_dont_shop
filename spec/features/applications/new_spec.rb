require 'rails_helper'

describe 'As a visitor' do
  describe 'When i visit the new application page' do

    before :each do
      @shelter_1 = Shelter.create!(name: "Boulder Humane Society",
                                   address: "1234 Wallabe Way",
                                   city: "Boulder",
                                   state: "CO",
                                   zip: 80302)

      @pet1 = @shelter_1.pets.create!(name: "Rex",
                                      sex: 1,
                                      adoptable: true,
                                      approximate_age: 2,
                                      description: "likes walks",
                                      image: "image_1.png")

      @pet2 = @shelter_1.pets.create!(name: "Hedi",
                                      sex: 0,
                                      adoptable: true,
                                      approximate_age: 3,
                                      description: "likes barking",
                                      image: "image_2.png")

      @pet3 = @shelter_1.pets.create!(name: "Bork",
                                      sex: 0,
                                      adoptable: true,
                                      approximate_age: 3,
                                      description: "likes barking",
                                      image: "image_2.png")


      @user1= User.create(username: "xxxxxxxxxxxx", password: "admin", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    end

    it 'I can submit an application with valid data' do
      visit pets_path
      click_link "Start an Application"
      expect(current_path).to eq(new_application_path)

      fill_in "name", with: "Julia Bloom"
      fill_in "street", with: "514 Old Street"
      fill_in "city", with: "Briancliffe"
      select "NY", from: "state"
      fill_in "zip_code", with: "80302"
      click_button "Submit"
      
      expect(current_path).to eq(application_path(Application.last.id))
     
      visit pets_path
      click_link "Start an Application"
      expect(current_path).to eq(new_application_path)

      fill_in "name", with: "Julia Bloom"
      fill_in "street", with: "514 Old Street"
      fill_in "city", with: "Briancliffe"
      select "NY", from: "state"
      fill_in "zip_code", with: "29"
      click_button "Submit"

      expect(page).to have_content("Application not created: Required information missing or invalid.")
    end
  end
end