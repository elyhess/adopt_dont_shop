require "rails_helper"

describe "As a visitor" do
  describe "When i visit an applications show page" do
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

      @user1= User.create(username: "x", password: "admin", role: 0)

      @bobby = Application.create!(name: "Bobby",
                                   street: "756 6th st.",
                                   city: "Boulder",
                                   state: "CO",
                                   zip_code: 80302,
                                   application_status: "In Progress", user_id: @user1.id)

      @sam = Application.create!(name: "Sam",
                                 street: "756 6th st.",
                                 city: "Boulder",
                                 state: "CO",
                                 zip_code: 80302,
                                 application_status: "In Progress", user_id: @user1.id)

      ApplicationPet.create!(application: @bobby, pet: @pet3)
      ApplicationPet.create!(application: @bobby, pet: @pet2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    end

    it "I see the attributes of my application" do
      visit application_path(@bobby)

      within "#main" do
        expect(page).to have_content("Name: #{@bobby.name}")
        expect(page).to have_content("Street: #{@bobby.street}")
        expect(page).to have_content("City: #{@bobby.city}")
        expect(page).to have_content("State: #{@bobby.state}")
        expect(page).to have_content("Zip-code: #{@bobby.zip_code}")
        expect(page).to have_content("Application Status: #{@bobby.application_status}")
        expect(page).to_not have_content("Description: #{@bobby.description}")
      end

      expect(page).to have_content("Pets applied for:")

      within "#pets-applied-for-#{@bobby.id}" do
        expect(page).to have_content(@pet2.name)
        expect(page).to have_content(@pet3.name) 
      end
    end

    it "Once I have added a pet to adopt i can submit my application after entering a brief description" do
      visit application_path(@bobby)

      expect(page).to have_content("Add a pet to this application")

      fill_in "pet_search", with: "Hedo"
      click_on "Search by Pet Name"
      expect(page).to have_link("Hedo - Adopt me")

      click_on "Hedo - Adopt me"
      expect(current_path).to eq(application_path(@bobby))

      fill_in :description, with: "I really want these pets."
      click_on "Submit"

      expect(current_path).to eq(application_path(@bobby))
      expect(current_path).to have_content(@bobby.description)
    end

    it "It does not allow me to proceed without entering a description" do
      visit application_path(@bobby)

      expect(page).to have_content("Add a pet to this application")

      fill_in "pet_search", with: "Hedo"
      click_on "Search by Pet Name"
      expect(page).to have_link("Hedo - Adopt me")

      click_on "Hedo - Adopt me"
      expect(current_path).to eq(application_path(@bobby))

      fill_in :description, with: ""
      click_on "Submit"

      expect(current_path).to eq(application_path(@bobby))
      expect(page).to have_content("Enter a valid description")
    end

    it "if i do not add pets i will not see a submit button" do
      visit application_path(@sam)

      expect(page).to have_content("Add a pet to this application")

      expect(page).to_not have_button("Submit")
    end
  end
end
