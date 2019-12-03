require 'rails_helper'

describe Pet, type: :model do
  describe "validations" do
    it {should validate_presence_of(:image)}
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:approximate_age)}
    it {should validate_presence_of(:sex)}
    it {should validate_presence_of(:description)}
    it {should validate_inclusion_of(:adoptable?).in_array([true,false])}
  end

  describe "relationships" do
    it {should belong_to :shelter}
  end

  describe "class methods" do
    it ".sort_pets_by_status" do
      boulder_bulldog_rescue = Shelter.create(name: "Boulder Bulldog Rescue", address: "2712 Slobber Circle", city: "Boulder", state: "CO", zip: 80205)
      howlz_n_jowlz = Shelter.create(name: "Howlz 'n Jowlz", address: "7943 Furry Friend Drive", city: "Colorado Springs", state: "CO", zip: 80207)

      botox = boulder_bulldog_rescue.pets.create(image: "https://slack-imgs.com/?c=1&o1=ro&url=https%3A%2F%2Fi.pinimg.com%2F564x%2Fc4%2F3e%2F7f%2Fc43e7f6a45aba8790a8c47d3a5d62ee8.jpg",
        name: 'Botox',
        description: 'So wrinkly!',
        approximate_age: 7,
        sex: 'Female',
        adoptable?: false)

      pumbaa = boulder_bulldog_rescue.pets.create(image: "https://slack-imgs.com/?c=1&o1=ro&url=https%3A%2F%2Fi.pinimg.com%2F564x%2Fc4%2F3e%2F7f%2Fc43e7f6a45aba8790a8c47d3a5d62ee8.jpg",
        name: 'Pumbaa',
        description: 'So wrinkly!',
        approximate_age: 3,
        sex: 'Male',
        adoptable?: false)

      henri = boulder_bulldog_rescue.pets.create(image: "https://scontent-den4-1.xx.fbcdn.net/v/t1.0-9/69959835_377201229643201_4012713976726028288_o.jpg?_nc_cat=109&_nc_oc=AQlSsxr7ocJQdJ_USDptWwC1yYaFJvmQcqU1h1os4Kf4OXE8xOGfJWdUvVwrGyxSXYQ&_nc_ht=scontent-den4-1.xx&oh=b38ee308df03b9d760c5e720905eda0b&oe=5E4D6B16",
        name: 'Henri',
        description: "With his heartwarming wrinkles and furrowed brow, he'll slobber his way into your heart!",
        approximate_age: 5,
        sex: 'Male')

      alfred = howlz_n_jowlz.pets.create(image: "https://scontent-den4-1.xx.fbcdn.net/v/t31.0-8/14608760_10153942326162816_2748710450820779939_o.jpg?_nc_cat=100&_nc_oc=AQnrfoKEaHR6I5dtefDwT7AGx_jSyJbGEabXvtbS9jMf2eGvl4_plvsK3eSmKjECppM&_nc_ht=scontent-den4-1.xx&oh=358dd965255af229bdc5ea8bb5090fca&oe=5E4AA5BB",
        name: 'Alfred',
        description: "Truly a beautiful wrinkly boi!",
        approximate_age: 2,
        sex: 'Male')

      winston = howlz_n_jowlz.pets.create(image: "https://scontent-den4-1.xx.fbcdn.net/v/t31.0-8/14608760_10153942326162816_2748710450820779939_o.jpg?_nc_cat=100&_nc_oc=AQnrfoKEaHR6I5dtefDwT7AGx_jSyJbGEabXvtbS9jMf2eGvl4_plvsK3eSmKjECppM&_nc_ht=scontent-den4-1.xx&oh=358dd965255af229bdc5ea8bb5090fca&oe=5E4AA5BB",
        name: 'Winston',
        description: "Truly a beautiful wrinkly boi!",
        approximate_age: 8,
        sex: 'Male')

      expected = [henri, alfred, winston, botox, pumbaa]
      expect(Pet.sort_pets_by_status).to eq(expected)
    end
  end
end
