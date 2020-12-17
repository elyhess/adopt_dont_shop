# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# rails db:purge db:migrate db:seed (to reset autoincremented ids)

Shelter.destroy_all
Pet.destroy_all

Application.destroy_all
ApplicationPet.destroy_all

shelter_1 = Shelter.create!(name: "Denver Humane Society",
                            address: "5455 Rover Dr.",
                            city: "Denver",
                            state: "CO",
                            zip: 80214)

shelter_2 = Shelter.create!(name: "Boulder Humane Society",
                            address: "1234 Wallabe Way",
                            city: "Boulder",
                            state: "CO",
                            zip: 80302)

pet1 = shelter_2.pets.create!(name: "Rex",
                              sex: 1,
                              adoptable: true,
                              approximate_age: 2,
                              description: "likes to eat",
                              image: "image_1.png")

pet2 = shelter_2.pets.create!(name: "Hoggus",
                              sex: 1,
                              adoptable: true,
                              approximate_age: 1,
                              description: "likes to be pet",
                              image: "image_2.png")

pet4 = shelter_2.pets.create!(name: "Piper",
                              sex: 0,
                              adoptable: true,
                              approximate_age: 2,
                              description: "likes drinking water",
                              image: "image_3.png")

pet3 = shelter_2.pets.create!(name: "Jack",
                              sex: 0,
                              adoptable: true,
                              approximate_age: 4,
                              description: "likes running",
                              image: "image_4.png")

pet5 = shelter_1.pets.create!(name: "Jibbs",
                              sex: 1,
                              adoptable: true,
                              approximate_age: 6,
                              description: "likes sitting",
                              image: "image_5.png")

pet6 = shelter_1.pets.create!(name: "Jax",
                              sex: 0,
                              adoptable: true,
                              approximate_age: 2,
                              description: "likes to dance",
                              image: "image_6.png")

pet7 = shelter_1.pets.create!(name: "Bianca",
                              sex: 0,
                              adoptable: true,
                              approximate_age: 3,
                              description: "likes stomping",
                              image: "image_7.png")

pet8 = shelter_1.pets.create!(name: "Cujo",
                              sex: 0,
                              adoptable: true,
                              approximate_age: 6,
                              description: "likes everything",
                              image: "image_8.png")

pet9 = shelter_1.pets.create!(name: "Trogdor",
                              sex: 1,
                              adoptable: true,
                              approximate_age: 4,
                              description: "likes rolling around",
                              image: "image_9.png")

pet10 = shelter_1.pets.create!(name: "Penelope",
                               sex: 0,
                               adoptable: true,
                               approximate_age: 9,
                               description: "likes rolling around",
                               image: "image_10.png")
