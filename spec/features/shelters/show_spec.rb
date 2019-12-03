require 'rails_helper'

RSpec.describe "shelter show page" do
  describe "as a visitor" do
    before(:each) do
      @shelter_1 = Shelter.create(name: "Gimme Shelter", address: "5218 Rolling Stones Avenue", city: "Denver", state: "CO", zip: 80203)
      @review_1 = @shelter_1.reviews.create!(title: "Would Recommend", rating: 4, content: "Good service, easy application process!")
      @review_2 = @shelter_1.reviews.create!(title: "Alright", rating: 3, content: "Nothing special, but they had an ok selection of pets and were quite clean.")
      @review_3 = @shelter_1.reviews.create!(title: "Awesome!", rating: 4, content: "They helped us adopt the perfect dog!", image: "https://i2.wp.com/www.wjbf.com/wp-content/uploads/sites/47/2018/07/Local_Animal_Shelter_Over_Crowded_0_49112321_ver1.0.jpg?resize=2560%2C1440&ssl=1")

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
  end
end
