require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "#total_count" do
    it "can calculate the total number of pets it has" do
      favorites = Favorite.new(["1", "2", "3"])

      expect(favorites.total_count).to eq(3)
    end
  end

  describe "#add_pet" do
    it "adds a pet to its contents" do
      favorites = Favorite.new(["1", "2", "3"])

      boulder_bulldog_rescue = Shelter.create(name: "Boulder Bulldog Rescue", address: "2712 Slobber Circle", city: "Boulder", state: "CO", zip: 80205)

      pet_3 = boulder_bulldog_rescue.pets.create(image: "https://i.pinimg.com/564x/aa/38/27/aa38272dbdb0b6ee03c17420b7de3c2c.jpg",
        name: 'Harry',
        description: "The most beautiful underbite you've ever seen!",
        approximate_age: 6,
        sex: 'Male',
        adoptable?: false)

      pet_4 = boulder_bulldog_rescue.pets.create(image: "https://i.pinimg.com/564x/ac/4c/3f/ac4c3f848136a5f59b973943c113723f.jpg",
          name: 'Tater Tot',
          description: "The cutest potato!",
          approximate_age: 8,
          sex: 'Female',
          adoptable?: false)

      favorites.add_pet(pet_3)
      favorites.add_pet(pet_4)

      expect(favorites.total_count).to eq(5)
    end
  end

  describe "#remove_pet" do
    it "removes a pet from its contents" do

      boulder_bulldog_rescue = Shelter.create(name: "Boulder Bulldog Rescue", address: "2712 Slobber Circle", city: "Boulder", state: "CO", zip: 80205)

      pet_1 = boulder_bulldog_rescue.pets.create(image: "https://i.pinimg.com/564x/aa/38/27/aa38272dbdb0b6ee03c17420b7de3c2c.jpg",
        name: 'Harry',
        description: "The most beautiful underbite you've ever seen!",
        approximate_age: 6,
        sex: 'Male',
        adoptable?: false)

      pet_2 = boulder_bulldog_rescue.pets.create(image: "https://i.pinimg.com/564x/ac/4c/3f/ac4c3f848136a5f59b973943c113723f.jpg",
          name: 'Tater Tot',
          description: "The cutest potato!",
          approximate_age: 8,
          sex: 'Female',
          adoptable?: false)

      pet_3 = boulder_bulldog_rescue.pets.create(image: "https://i.pinimg.com/564x/ac/4c/3f/ac4c3f848136a5f59b973943c113723f.jpg",
          name: 'Tater Tot',
          description: "The cutest potato!",
          approximate_age: 8,
          sex: 'Female',
          adoptable?: false)

      pet_4 = boulder_bulldog_rescue.pets.create(image: "https://i.pinimg.com/564x/ac/4c/3f/ac4c3f848136a5f59b973943c113723f.jpg",
          name: 'Tater Tot',
          description: "The cutest potato!",
          approximate_age: 8,
          sex: 'Female',
          adoptable?: false)

      pet_5 = boulder_bulldog_rescue.pets.create(image: "https://i.pinimg.com/564x/ac/4c/3f/ac4c3f848136a5f59b973943c113723f.jpg",
          name: 'Tater Tot',
          description: "The cutest potato!",
          approximate_age: 8,
          sex: 'Female',
          adoptable?: false)

      favorites = Favorite.new([pet_1.id, pet_2.id, pet_3.id, pet_4.id, pet_5.id])
      favorites.remove_pet(pet_2.id)
      favorites.remove_pet(pet_5.id)

      expect(favorites.total_count).to eq(3)
    end
  end

  describe "instance methods" do
    it "#included_in_favorites?" do
      favorites = Favorite.new([])

      boulder_bulldog_rescue = Shelter.create(name: "Boulder Bulldog Rescue", address: "2712 Slobber Circle", city: "Boulder", state: "CO", zip: 80205)

      pet_2 = boulder_bulldog_rescue.pets.create(image: "https://i.pinimg.com/564x/aa/38/27/aa38272dbdb0b6ee03c17420b7de3c2c.jpg",
        name: 'Nugget',
        description: "Cuter than a chicken",
        approximate_age: 8,
        sex: 'Male',
        adoptable?: false)

      pet_3 = boulder_bulldog_rescue.pets.create(image: "https://i.pinimg.com/564x/aa/38/27/aa38272dbdb0b6ee03c17420b7de3c2c.jpg",
        name: 'Harry',
        description: "The most beautiful underbite you've ever seen!",
        approximate_age: 6,
        sex: 'Male',
        adoptable?: false)

      pet_4 = boulder_bulldog_rescue.pets.create(image: "https://i.pinimg.com/564x/ac/4c/3f/ac4c3f848136a5f59b973943c113723f.jpg",
          name: 'Tater Tot',
          description: "The cutest potato!",
          approximate_age: 8,
          sex: 'Female',
          adoptable?: false)


      favorites.add_pet(pet_3)

      expect(favorites.included_in_favorites?(pet_3)).to eq(true)
      expect(favorites.included_in_favorites?(pet_4)).to eq(false)
    end
  end
end
