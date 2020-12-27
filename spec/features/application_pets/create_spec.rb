require "rails_helper"

describe "As a visitor" do
  describe "When i visit an application show page" do
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

      @pet4 = @shelter_1.pets.create!(name: "Hedo",
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

      @user = User.create(username: "admin", password: "admin", role: 1)
      @user1= User.create(username: "x", password: "admin", role: 0)

      @bobby = Application.create!(name: "Bobby",
                                   street: "756 6th st.",
                                   city: "Boulder",
                                   state: "CO",
                                   zip_code: 80302,
                                   application_status: "In Progress", user_id: @user1.id)
                                   
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    end

    it 'I see can add a pet to my application' do
      visit application_path(@bobby)

      expect(page).to have_content("Add a pet to this application")

      fill_in "pet_search" , with: "Hedi"

      click_on "Search by Pet Name"

      expect(page).to have_link("Hedi - Adopt me")

      click_on "Hedi - Adopt me"

      expect(current_path).to eq(application_path(@bobby))

      within("#pets-applied-for-#{@bobby.id}") do
        within("#pet-id-#{@pet2.id}") do
          expect(page).to have_content(@pet2.name)
          expect(page).to_not have_content(@pet4.name)
        end
      end
    end

    it "I cant add a pet if i've already added it" do
      visit application_path(@bobby)

      expect(page).to have_content("Add a pet to this application")

      fill_in "pet_search" , with: "Hedi"
      click_on "Search by Pet Name"

      expect(page).to have_link("Hedi - Adopt me")

      click_on "Hedi - Adopt me"

      expect(current_path).to eq(application_path(@bobby))

      fill_in "pet_search" , with: "Hedi"
      click_on "Search by Pet Name"

      expect(page).to have_link("Hedi - Adopt me")

      click_on "Hedi - Adopt me"

      expect(page).to have_content("You've already added this pet.")
    end
  end
end
