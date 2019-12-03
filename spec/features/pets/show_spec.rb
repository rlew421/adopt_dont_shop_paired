require 'rails_helper'

RSpec.describe "pet show page" do
  describe "as a visitor" do
    it "I see the pet with that id including the pet's:
    - image
    - name
    - description
    - approximate age
    - sex
    - adoptable/pending adoption status" do

      boulder_bulldog_rescue = Shelter.create(name: "Boulder Bulldog Rescue", address: "2712 Slobber Circle", city: "Boulder", state: "CO", zip: 80205)
      henri = boulder_bulldog_rescue.pets.create(image: "https://scontent-den4-1.xx.fbcdn.net/v/t1.0-9/69959835_377201229643201_4012713976726028288_o.jpg?_nc_cat=109&_nc_oc=AQlSsxr7ocJQdJ_USDptWwC1yYaFJvmQcqU1h1os4Kf4OXE8xOGfJWdUvVwrGyxSXYQ&_nc_ht=scontent-den4-1.xx&oh=b38ee308df03b9d760c5e720905eda0b&oe=5E4D6B16",
                          name: 'Henri',
                          description: "With his heartwarming wrinkles and furrowed brow, he'll slobber his way into your heart!",
                          approximate_age: 5,
                          sex: 'Male')

      visit "/pets/#{henri.id}"

      expect(page).to have_css("img[src*='#{henri.image}']")
      expect(page).to have_content(henri.name)
      expect(page).to have_content(henri.description)
      expect(page).to have_content("Age: #{henri.approximate_age}")
      expect(page).to have_content("Sex: #{henri.sex}")
      expect(page).to have_content("Status: Adoptable")
    end
  end
end
