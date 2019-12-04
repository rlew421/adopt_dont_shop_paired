require 'rails_helper'

describe "review creation" do
  it "I see a link to add a new review for this shelter that takes me to a form where I enter:
    - title
    - rating
    - have_content
    - optional image" do

    shelter_1 = Shelter.create(name: "Gimme Shelter", address: "5218 Rolling Stones Avenue", city: "Denver", state: "CO", zip: 80203)
    visit "/shelters/#{shelter_1.id}"

    click_link "Add Review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

    fill_in :title, with: "Awesome shelter"
    fill_in :rating, with: 5
    fill_in :content, with: "The staff was really helpful and the adoption process was seamless"
    fill_in :image, with: "https://wordpress.accuweather.com/wp-content/uploads/2019/07/animal-shelter-arkansas.jpg"

    click_button "Create Review"
    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content("Awesome shelter")
    expect(page).to have_content("5")
    expect(page).to have_content("The staff was really helpful and the adoption process was seamless")
    expect(page).to have_css("img[src*='https://wordpress.accuweather.com/wp-content/uploads/2019/07/animal-shelter-arkansas.jpg']")
  end

  it "when I fail to fill out a field and try to submit I see a flash message telling me to fill out what I missed" do
    shelter_1 = Shelter.create(name: "Gimme Shelter", address: "5218 Rolling Stones Avenue", city: "Denver", state: "CO", zip: 80203)
    visit "/shelters/#{shelter_1.id}"

    click_link "Add Review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

    fill_in :title, with: "Awesome shelter"
    fill_in :rating, with: 5
    fill_in :image, with: "https://wordpress.accuweather.com/wp-content/uploads/2019/07/animal-shelter-arkansas.jpg"

    click_button "Create Review"
    expect(page).to have_content("Content can't be blank")
  end
end
