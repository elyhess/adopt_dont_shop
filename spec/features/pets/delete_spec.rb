require 'rails_helper'

RSpec.describe 'Delete pet from pet show page' do
  before :each do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
    @shelter3 = Shelter.create!(name: "Shell Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
    @user1= User.create(username: "x", password: "admin", role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
  end

  it "can delete a pet from the pet show page" do
    visit "/pets/#{@pet1.id}"

    expect(page).to have_content(@pet1.name)

    click_button "Delete Pet"

    expect(current_path).to eq("/pets")

    expect(page).to_not have_content(@pet1.name)
    expect(page).to have_content(@pet2.name)
  end
end
