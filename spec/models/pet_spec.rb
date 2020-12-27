require 'rails_helper'

describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to :shelter }
    it { should have_many(:applications).through(:application_pets) }
    it {should have_many(:application_pets).dependent(:destroy)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :sex}
    it {should validate_numericality_of(:approximate_age).is_greater_than_or_equal_to(0)}

    it 'is created as adoptable by default' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(true)
    end

    it 'can be created as not adoptable' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(adoptable: false, name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(false)
    end

    it 'can be male' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :male, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('male')
      expect(pet.male?).to be(true)
      expect(pet.female?).to be(false)
    end

    it 'can be female' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('female')
      expect(pet.female?).to be(true)
      expect(pet.male?).to be(false)
    end
  end

  describe 'class methods' do
    it '.search_by_pet_name' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet1 = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
      pet2 = shelter.pets.create!(sex: :female, name: "Floppy", approximate_age: 3, description: 'super cute')
      pet3 = shelter.pets.create!(sex: :female, name: "Borko", approximate_age: 3, description: 'super cute')

      expect(Pet.search_pet_by_name("Fl")).to eq([pet1, pet2])
      expect(Pet.search_pet_by_name("bork")).to eq([pet3])
    end

    it '.make_adopted' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet1 = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
      pet2 = shelter.pets.create!(sex: :female, name: "Floppy", approximate_age: 3, description: 'super cute')
      pet3 = shelter.pets.create!(sex: :female, name: "Borko", approximate_age: 3, description: 'super cute')
      
      expect(Pet.make_adopted).to eq(3)
    end

    it '.avg_age' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet1 = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 0, description: 'super cute')
      pet2 = shelter.pets.create!(sex: :female, name: "Floppy", approximate_age: 1, description: 'super cute')
      pet3 = shelter.pets.create!(sex: :female, name: "Borko", approximate_age: 2, description: 'super cute')

      expect(Pet.avg_age).to eq(1)
    end

    it '.adoptable_count' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet1 = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 0, description: 'super cute', adoptable: true)
      pet2 = shelter.pets.create!(sex: :female, name: "Floppy", approximate_age: 1, description: 'super cute', adoptable: true)
      pet3 = shelter.pets.create!(sex: :female, name: "Borko", approximate_age: 2, description: 'super cute', adoptable: false)

      expect(Pet.adoptable_count).to eq(2)
    end

    it '.adopted_count' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet1 = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 0, description: 'super cute', adoptable: true)
      pet2 = shelter.pets.create!(sex: :female, name: "Floppy", approximate_age: 1, description: 'super cute', adoptable: true)
      pet3 = shelter.pets.create!(sex: :female, name: "Borko", approximate_age: 2, description: 'super cute', adoptable: false)

      expect(Pet.adopted_count).to eq(1)
    end

    it '.action_required' do
      shelter = Shelter.create!(name: "Pet Rescue", address: "123 Adoption Ln.", city: "Denver", state: "CO", zip: "80222")
      shelter2 = Shelter.create!(name: "Pet Rescue", address: "123 Adoption Ln.", city: "Denver", state: "CO", zip: "80222")

      pet5 = shelter.pets.create!(sex: :female, name: "lena", approximate_age: 6, description: "sort of cute")
      pet6 = shelter.pets.create!(sex: :male, name: "ed", approximate_age: 1, description: "scruffy cute")
      pet7 = shelter2.pets.create!(sex: :female, name: "fark", approximate_age: 2, description: "mega cute")
      user1= User.create(username: "x", password: "admin", role: 0)

      poe = Application.create!(name: "Poe",
                                 street: "666 18th st.",
                                 city: "Lakewood",
                                 state: "CO",
                                 zip_code: 80511,
                                 application_status: "Pending",
                                 description: "I want these pets.", user_id: user1.id)

      bob = Application.create!(name: "bob",
                                 street: "1231 6th st.",
                                 city: "Louisville",
                                 state: "CO",
                                 zip_code: 82111,
                                 application_status: "Pending",
                                 description: "I want these pets.", user_id: user1.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      ApplicationPet.create!(application: bob, pet: pet5, status: "In Progress")
      ApplicationPet.create!(application: bob, pet: pet6, status: "In Progress")

      ApplicationPet.create!(application: poe, pet: pet7, status: "Rejected")

      expect(Pet.action_required.size).to eq(2)
    end
  end
  
end
