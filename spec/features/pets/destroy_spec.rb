require 'rails_helper'

RSpec.describe "when I visit a pet show page" do
  it "I can click a link that deletes that pet" do
    boulder_bulldog_rescue = Shelter.create!(name: "Boulder Bulldog Rescue", address: "2712 Slobber Circle", city: "Boulder", state: "CO", zip: 80205)
    henri = boulder_bulldog_rescue.pets.create!(image: "https://scontent-den4-1.xx.fbcdn.net/v/t1.0-9/69959835_377201229643201_4012713976726028288_o.jpg?_nc_cat=109&_nc_oc=AQlSsxr7ocJQdJ_USDptWwC1yYaFJvmQcqU1h1os4Kf4OXE8xOGfJWdUvVwrGyxSXYQ&_nc_ht=scontent-den4-1.xx&oh=b38ee308df03b9d760c5e720905eda0b&oe=5E4D6B16",
                        name: 'Henri',
                        description: "With his heartwarming wrinkles and furrowed brow, he'll slobber his way into your heart!",
                        approximate_age: 5,
                        sex: 'Male')

    visit "/pets/#{henri.id}"

    click_link "Delete #{henri.name}"

    expect(current_path).to eq("/pets")
    expect(page).to_not have_css("img[src*='#{henri.image}']")
    expect(page).to_not have_content(henri.name)
    expect(page).to_not have_content(henri.approximate_age)
    expect(page).to_not have_content(henri.sex)
  end
end
