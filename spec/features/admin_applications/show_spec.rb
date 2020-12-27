require "rails_helper"

describe "As a visitor" do
  describe "when i visit the admin applications show page" do
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
      @user = User.create(username: "adminasdasdasdasda", password: "admiasdan", role: 1)
      @user1 = User.create(username: "defxxxxxxxxxxault", password: "default", role: 0)

      @bobby = Application.create!(name: "Bobby",
                                   street: "756 6th st.",
                                   city: "Boulder",
                                   state: "CO",
                                   zip_code: 80302,
                                   application_status: "Pending",
                                   description: "I really want these pets.",
                                   user_id: @user1.id)
      @abby = Application.create!(name: "Abby",
                                  street: "2222 6th st.",
                                  city: "Denver",
                                  state: "CO",
                                  zip_code: 80214,
                                  application_status: "Pending",
                                  description: "I want these pets.",
                                  user_id: @user1.id)

      ApplicationPet.create!(application: @bobby, pet: @pet3)
      ApplicationPet.create!(application: @bobby, pet: @pet2)
      ApplicationPet.create!(application: @abby, pet: @pet1)
      ApplicationPet.create!(application: @abby, pet: @pet4)

      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "I can approve a pet for adoption" do
      visit admin_application_path(@bobby)

      within "#pets-applied-for-#{@bobby.id}" do
        within "#pets-id-#{@pet2.id}" do
          expect(page).to have_content(@pet2.name)
          click_button "Approve"
          expect(page).to have_content("#{@pet2.name} - Approved")
          expect(page).to_not have_button("Approve")
          expect(page).to_not have_button("Reject")
        end
      end
    end

    it "Once all pets on an application are approved, the application status is appoved" do
      visit admin_application_path(@bobby)
      within "#pets-applied-for-#{@bobby.id}" do
        within "#pets-id-#{@pet2.id}" do
          click_button "Approve"
        end
        within "#pets-id-#{@pet3.id}" do
          click_button "Approve"
        end
      end
      within "#main" do
        expect(page).to have_content("Application Status: Approved")
      end
    end

    it "Once a pet on an application are rejected, the application status is rejected" do
      visit admin_application_path(@bobby)
      within "#pets-applied-for-#{@bobby.id}" do
        within "#pets-id-#{@pet3.id}" do
          click_button "Reject"
        end
      end
      within "#main" do
        expect(page).to have_content("Application Status: Rejected")
      end
    end

    it "pets can only have one approved application on them at a time" do
      shelter_2 = Shelter.create!(name: "Boulder Humane Society",
                                   address: "1234 Wallabe Way",
                                   city: "Boulder",
                                   state: "CO",
                                   zip: 80302)

      pet1 = shelter_2.pets.create!(name: "Rex",
                                      sex: 1,
                                      adoptable: true,
                                      approximate_age: 2,
                                      description: "likes walks",
                                      image: "image_1.png")

      pet2 = shelter_2.pets.create!(name: "Hedi",
                                      sex: 0,
                                      adoptable: true,
                                      approximate_age: 3,
                                      description: "likes barking",
                                      image: "image_2.png")

      pet4 = shelter_2.pets.create!(name: "Hedo",
                                      sex: 0,
                                      adoptable: true,
                                      approximate_age: 3,
                                      description: "likes barking",
                                      image: "image_2.png")

      pet3 = shelter_2.pets.create!(name: "Bork",
                                      sex: 0,
                                      adoptable: true,
                                      approximate_age: 3,
                                      description: "likes barking",
                                      image: "image_2.png")

      user = User.create!(username: "123123123", password: "12312312", role: 1)
      user1 = User.create!(username: "defau12312312lt", password: "123123", role: 0)
      applicant1 = Application.create!(name: "Bobby",
                                        street: "756 6th st.",
                                        city: "Boulder",
                                        state: "CO",
                                        zip_code: 80302,
                                        application_status: "Pending",
                                        description: "I really want these pets.", user_id: user1.id)

      applicant2 = Application.create!(name: "Abby",
                                        street: "2222 6th st.",
                                        city: "Denver",
                                        state: "CO",
                                        zip_code: 80214,
                                        application_status: "Pending",
                                        description: "I want these pets.", user_id: user1.id)

      ApplicationPet.create!(application: applicant1, pet: pet3)
      ApplicationPet.create!(application: applicant1, pet: pet2)
      ApplicationPet.create!(application: applicant2, pet: pet1)
      ApplicationPet.create!(application: applicant2, pet: pet3)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit admin_application_path(applicant1)

      within "#pets-applied-for-#{applicant1.id}" do
        within "#pets-id-#{pet3.id}" do
          click_button "Approve"
        end
        within "#pets-id-#{pet2.id}" do
          click_button "Approve"
        end
      end

      visit admin_application_path(applicant2)

      within "#pets-applied-for-#{applicant2.id}" do
        within "#pets-id-#{pet1.id}" do
          click_button "Approve"
        end
        within "#pets-id-#{pet3.id}" do
          expect(page).to have_content("This pet has already been adopted")
          click_button "Reject"
        end
      end

      expect(page).to have_content("Application Status: Rejected")

    end
  end
end
