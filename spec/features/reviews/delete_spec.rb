require 'rails_helper'

describe "When I visit a shelter's show page" do
  describe "Shelter review delete" do
    before(:each) do
      @shelter_1 = Shelter.create(name: "Gimme Shelter", address: "5218 Rolling Stones Avenue", city: "Denver", state: "CO", zip: 80203)
      @review_1 = @shelter_1.reviews.create!(
        title: "It was good",
        rating: 4,
        content: "The staff was really helpful and the adoption process was seamless",
        image: "https://wordpress.accuweather.com/wp-content/uploads/2019/07/animal-shelter-arkansas.jpg")

      @review_2 = @shelter_1.reviews.create!(
        title: "Perfectly adequate",
        rating: 3,
        content: "Run of the mill shelter")

        visit "/shelters/#{@shelter_1.id}"
    end

    it "I see a link next to each shelter review to delete that review, and when clicked, the review is destroyed." do
      within "#review-#{@review_2.id}" do
        click_link "Delete Review"
      end

      expect(current_path).to eq("/shelters/#{@review_1.shelter.id}")
      expect(page).to_not have_content("Perfectly adequate")
      expect(page).to_not have_content("Run of the mill shelter")
    end

    it "I can see the remaining, undeleted reviews" do
      within "#review-#{@review_1.id}" do
      expect(page).to have_content("It was good")
      expect(page).to have_content("The staff was really helpful and the adoption process was seamless")
      expect(page).to have_css("img[src*='#{@review_1.image}']")
      end
    end
  end
end
