require 'rails_helper'

describe 'As a visitor' do
  describe 'when i visit the admin applications show page' do
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

      @bobby = Application.create!(name: "Bobby",
                                        street: "756 6th st.",
                                        city: "Boulder",
                                        state: "CO",
                                        zip_code: 80302,
                                        application_status: "Pending",
                                        description: "I really want these pets.")
      @abby = Application.create!(name: "Abby",
                                          street: "2222 6th st.",
                                          city: "Denver",
                                          state: "CO",
                                          zip_code: 80214,
                                          application_status: "Pending",
                                          description: "I want these pets.")
      
      ApplicationPet.create!(application: @bobby, pet: @pet3)
      ApplicationPet.create!(application: @bobby, pet: @pet2)
      ApplicationPet.create!(application: @abby, pet: @pet1)
    end

    it 'I can approve a pet for adoption' do
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

      # visit admin_application_path(@abby)

      # within "#pets-applied-for-#{@abby.id}" do
      #   within "#pets-id-#{@pet1.id}" do
      #   expect(page).to have_content(@pet1.name)
      #   click_button "Approve"
      #   expect(page).to have_content("#{@pet1.name} has been approved")
      #   end
      # end

      
    end
  end
end