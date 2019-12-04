require 'rails_helper'

describe "When I visit a shelter's show page" do
  describe "Shelter review edit" do
    before(:each) do
      @shelter_1 = Shelter.create(name: "Gimme Shelter", address: "5218 Rolling Stones Avenue", city: "Denver", state: "CO", zip: 80203)
      @review_1 = @shelter_1.reviews.create!(
        title: "Perfectly adequate",
        rating: 3,
        content: "Run of the mill shelter")

      @review_2 = @shelter_1.reviews.create!(
        title: "It was good",
        rating: 4,
        content: "The staff was really helpful and the adoption process was seamless",
        image: "https://wordpress.accuweather.com/wp-content/uploads/2019/07/animal-shelter-arkansas.jpg")

        visit "/shelters/#{@shelter_1.id}"
    end

    it "I can click a link next to each review that takes me to an edit form" do
      within "#review-#{@review_1.id}" do
        click_link "Edit Review"
      end

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit")

      visit "/shelters/#{@shelter_1.id}"

      within "#review-#{@review_2.id}" do
        click_link "Edit Review"
      end

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@review_2.id}/edit")

      fill_in :title, with: "Awesome shelter"
      fill_in :content, with: "The application process was easy and painless. Love the pupper!"

      click_button "Update Review"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      expect(page).to have_content("Awesome shelter")
      expect(page).to have_content("4.0")
      expect(page).to have_content("The application process was easy and painless. Love the pupper!")
      expect(page).to have_css("img[src*='#{@review_2.image}']")
      expect(page).to_not have_content("It was good")
    end

    it "I can see the prepopulated fields for that review" do
      within "#review-#{@review_2.id}" do
        click_link "Edit Review"
      end

      expect(find_field(:title).value).to eq(@review_2.title)
      expect(find_field(:rating).value).to eq("#{@review_2.rating}")
      expect(find_field(:content).value).to eq(@review_2.content)
      expect(find_field(:image).value).to eq(@review_2.image)
    end
  end
end
