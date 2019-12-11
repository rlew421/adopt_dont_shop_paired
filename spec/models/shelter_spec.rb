require 'rails_helper'

describe Shelter, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zip)}
  end

  describe "relationships" do
    it {should have_many(:pets).dependent(:destroy)}
    it {should have_many(:reviews).dependent(:destroy)}
  end

  describe "instance methods" do
    before(:each) do
      @boulder_bulldog_rescue = Shelter.create(name: "Boulder Bulldog Rescue", address: "2712 Slobber Circle", city: "Boulder", state: "CO", zip: 80205)
      @howlz_n_jowlz = Shelter.create(name: "Howlz 'n Jowlz", address: "7943 Furry Friend Drive", city: "Colorado Springs", state: "CO", zip: 80207)

      @pet_1 = @boulder_bulldog_rescue.pets.create(image: "https://scontent-den4-1.xx.fbcdn.net/v/t1.0-9/69959835_377201229643201_4012713976726028288_o.jpg?_nc_cat=109&_nc_oc=AQlSsxr7ocJQdJ_USDptWwC1yYaFJvmQcqU1h1os4Kf4OXE8xOGfJWdUvVwrGyxSXYQ&_nc_ht=scontent-den4-1.xx&oh=b38ee308df03b9d760c5e720905eda0b&oe=5E4D6B16",
        name: 'Henri',
        description: "With his heartwarming wrinkles and furrowed brow, he'll slobber his way into your heart!",
        approximate_age: 5,
        sex: 'Male')

      @pet_2 = @howlz_n_jowlz.pets.create(image: "https://scontent-den4-1.xx.fbcdn.net/v/t31.0-8/14608760_10153942326162816_2748710450820779939_o.jpg?_nc_cat=100&_nc_oc=AQnrfoKEaHR6I5dtefDwT7AGx_jSyJbGEabXvtbS9jMf2eGvl4_plvsK3eSmKjECppM&_nc_ht=scontent-den4-1.xx&oh=358dd965255af229bdc5ea8bb5090fca&oe=5E4AA5BB",
        name: 'Alfred',
        description: "Truly a beautiful wrinkly boi!",
        approximate_age: 2,
        sex: 'Male')

      @pet_3 = @boulder_bulldog_rescue.pets.create(image: "https://i.pinimg.com/564x/4b/0c/99/4b0c99ace72fdfc65b2853fa14d41a8b.jpg",
        name: 'Toast',
        description: "She snorts, she farts, she's sweeter than French toast!",
        approximate_age: 4,
        sex: 'Female')

      @review_1 = @boulder_bulldog_rescue.reviews.create(title: "The cutest bulldogs!", content: "This shelter takes in a lot of surrenders, and they take care of their bulldogs well!", rating: 5)
      @review_2 = @boulder_bulldog_rescue.reviews.create(title: "Bulldog Experts", content: "They know how to take care of this breed.", rating: 4)
      @review_3 = @boulder_bulldog_rescue.reviews.create(title: "Interesting...", content: "They have a wide variety of pets, but we're not sure if they're all safe or legal to own.", rating: 2)

      @application_1 = @pet_1.applications.create!( name: "James Earl Jones",
                                                address: "1703 11th Ave",
                                                city:"Boulder" ,
                                                state: "CO",
                                                zip: 80423,
                                                phone_number: 3036077527,
                                                description: "I need an adventure buddy")

      @application_2 = @pet_1.applications.create!( name: "John Doe",
                                                address: "1703 11th Ave",
                                                city:"Boulder" ,
                                                state: "CO",
                                                zip: 80423,
                                                phone_number: 3036077527,
                                                description: "I need a furry friend")

      @application_3 = @pet_3.applications.create!( name: "John Doe",
                                                address: "1703 11th Ave",
                                                city:"Boulder" ,
                                                state: "CO",
                                                zip: 80423,
                                                phone_number: 3036077527,
                                                description: "I need a furry friend")

      @application_4 = @pet_2.applications.create!( name: "John Doe",
                                                address: "1703 11th Ave",
                                                city:"Boulder" ,
                                                state: "CO",
                                                zip: 80423,
                                                phone_number: 3036077527,
                                                description: "I need a furry friend")
    end

    it ".pet_count" do
      expect(@boulder_bulldog_rescue.pet_count).to eq(2)
    end

    it ".average_rating" do
      expect(@boulder_bulldog_rescue.average_rating).to eq(3.66666666666667)
    end

    it ".application_count" do
      expect(@boulder_bulldog_rescue.application_count).to eq(3)
      expect(@howlz_n_jowlz.application_count).to eq(1)
    end
  end
end
