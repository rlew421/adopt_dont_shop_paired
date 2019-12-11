require 'rails_helper'

RSpec.describe "shelter show page" do
  describe "as a visitor" do
    before(:each) do
      @shelter_1 = Shelter.create(name: "Gimme Shelter", address: "5218 Rolling Stones Avenue", city: "Denver", state: "CO", zip: 80203)
      @shelter_2 = Shelter.create(name: "Gimme Shelter", address: "5218 Rolling Stones Avenue", city: "Denver", state: "CO", zip: 80203)

      @review_1 = @shelter_1.reviews.create!(title: "Would Recommend", rating: 4, content: "Good service, easy application process!")
      @review_2 = @shelter_1.reviews.create!(title: "Alright", rating: 3, content: "Nothing special, but they had an ok selection of pets and were quite clean.")
      @review_3 = @shelter_1.reviews.create!(title: "Awesome!", rating: 4, content: "They helped us adopt the perfect dog!", image: "https://i2.wp.com/www.wjbf.com/wp-content/uploads/sites/47/2018/07/Local_Animal_Shelter_Over_Crowded_0_49112321_ver1.0.jpg?resize=2560%2C1440&ssl=1")

      @pet_1 = @shelter_1.pets.create(image: "https://scontent-den4-1.xx.fbcdn.net/v/t1.0-9/69959835_377201229643201_4012713976726028288_o.jpg?_nc_cat=109&_nc_oc=AQlSsxr7ocJQdJ_USDptWwC1yYaFJvmQcqU1h1os4Kf4OXE8xOGfJWdUvVwrGyxSXYQ&_nc_ht=scontent-den4-1.xx&oh=b38ee308df03b9d760c5e720905eda0b&oe=5E4D6B16",
        name: 'Henri',
        description: "With his heartwarming wrinkles and furrowed brow, he'll slobber his way into your heart!",
        approximate_age: 5,
        sex: 'Male')

      @pet_2 = @shelter_2.pets.create(image: "https://scontent-den4-1.xx.fbcdn.net/v/t31.0-8/14608760_10153942326162816_2748710450820779939_o.jpg?_nc_cat=100&_nc_oc=AQnrfoKEaHR6I5dtefDwT7AGx_jSyJbGEabXvtbS9jMf2eGvl4_plvsK3eSmKjECppM&_nc_ht=scontent-den4-1.xx&oh=358dd965255af229bdc5ea8bb5090fca&oe=5E4AA5BB",
        name: 'Alfred',
        description: "Truly a beautiful wrinkly boi!",
        approximate_age: 2,
        sex: 'Male')

      @pet_3 = @shelter_1.pets.create(image: "https://i.pinimg.com/564x/4b/0c/99/4b0c99ace72fdfc65b2853fa14d41a8b.jpg",
        name: 'Toast',
        description: "She snorts, she farts, she's sweeter than French toast!",
        approximate_age: 4,
        sex: 'Female')

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
      visit "/shelters/#{@shelter_1.id}"
    end

    it "I see the shelter with that id including the shelter's:
      - name
      - address
      - city
      - state
      - zip" do


      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_1.address)
      expect(page).to have_content(@shelter_1.city)
      expect(page).to have_content(@shelter_1.state)
      expect(page).to have_content(@shelter_1.zip)
    end

    it "I see a link that takes me to that shelter's pets page" do
      click_link "View #{@shelter_1.name}'s Pets"
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
    end

    it "I see a list of reviews for that shelter where each review has a:
      - title
      - rating
      - content
      - optional picture" do

      within "#review-#{@review_1.id}" do
        expect(page).to have_content(@review_1.title)
        expect(page).to have_content(@review_1.rating)
        expect(page).to have_content(@review_1.content)
      end

      within "#review-#{@review_2.id}" do
        expect(page).to have_content(@review_2.title)
        expect(page).to have_content(@review_2.rating)
        expect(page).to have_content(@review_2.content)
      end

      within "#review-#{@review_3.id}" do
        expect(page).to have_content(@review_3.title)
        expect(page).to have_css("img[src*='#{@review_3.image}']")
      end
    end

    it "I see statistics for that shelter, including:
    - count of pets that are at that shelter
    - average shelter review average_rating
    - number of applications on file for that shelter" do

      within "#shelter-statistics" do
        expect(page).to have_content("Number of Pets at #{@shelter_1.name}: 2")
        expect(page).to have_content("Average Rating for #{@shelter_1.name}: 3.67")
        expect(page).to have_content("Number of Applications for #{@shelter_1.name}: 3")
      end
    end
  end
end
