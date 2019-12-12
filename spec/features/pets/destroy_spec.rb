require 'rails_helper'

RSpec.describe "when I visit a pet show page" do
  before :each do
  @boulder_bulldog_rescue = Shelter.create!(name: "Boulder Bulldog Rescue", address: "2712 Slobber Circle", city: "Boulder", state: "CO", zip: 80205)
  @henri = @boulder_bulldog_rescue.pets.create!(image: "https://scontent-den4-1.xx.fbcdn.net/v/t1.0-9/69959835_377201229643201_4012713976726028288_o.jpg?_nc_cat=109&_nc_oc=AQlSsxr7ocJQdJ_USDptWwC1yYaFJvmQcqU1h1os4Kf4OXE8xOGfJWdUvVwrGyxSXYQ&_nc_ht=scontent-den4-1.xx&oh=b38ee308df03b9d760c5e720905eda0b&oe=5E4D6B16",
                      name: 'Henri',
                      description: "With his heartwarming wrinkles and furrowed brow, he'll slobber his way into your heart!",
                      approximate_age: 5,
                      sex: 'Male')

  visit "/pets/#{@henri.id}"
  end

  it "I can click a link that deletes that pet" do
    click_link "Delete #{@henri.name}"

    expect(current_path).to eq("/pets")
    expect(page).to_not have_css("img[src*='#{@henri.image}']")
    expect(page).to_not have_content(@henri.name)
    expect(page).to_not have_content(@henri.approximate_age)
    expect(page).to_not have_content(@henri.sex)
  end

  it "I cannot delete a pet who has an approved application" do
    pet = @boulder_bulldog_rescue.pets.create!(image: "https://scontent-den4-1.xx.fbcdn.net/v/t1.0-9/69959835_377201229643201_4012713976726028288_o.jpg?_nc_cat=109&_nc_oc=AQlSsxr7ocJQdJ_USDptWwC1yYaFJvmQcqU1h1os4Kf4OXE8xOGfJWdUvVwrGyxSXYQ&_nc_ht=scontent-den4-1.xx&oh=b38ee308df03b9d760c5e720905eda0b&oe=5E4D6B16",
                        name: 'Pet 1',
                        description: "With his heartwarming wrinkles and furrowed brow, he'll slobber his way into your heart!",
                        approximate_age: 5,
                        sex: 'Male')

    application = pet.applications.create!( name: "John Doe",
                                              address: "9827 Denver Drive",
                                              city:"Denver" ,
                                              state: "CO",
                                              zip: 80204,
                                              phone_number: 2938193029,
                                              description: "Looking for a furry friend")

    visit "/applications/#{application.id}"
    within "#pets_applied_for-#{pet.id}" do
      click_link "Approve Application For #{pet.name}"
    end

    visit "/pets"
    within "#pet-#{pet.id}" do
      expect(page).to_not have_link("Delete")
    end

    visit "/pets/#{pet.id}"
    expect(page).to_not have_link("Delete #{pet.name}")

    visit "/shelters/#{@boulder_bulldog_rescue.id}/pets"
    within "#pet-#{pet.id}" do
      expect(page).to_not have_link("Delete")
    end

    visit "/shelters/#{@boulder_bulldog_rescue.id}/pets/#{pet.id}"
    expect(page).to_not have_link("Delete")
  end

  it "When I delete a pet that pet is removed from favorites" do
    shelter = Shelter.create!(name: "Boulder Bulldog Rescue", address: "2712 Slobber Circle", city: "Boulder", state: "CO", zip: 80205)
    pet = @boulder_bulldog_rescue.pets.create!(image: "https://scontent-den4-1.xx.fbcdn.net/v/t1.0-9/69959835_377201229643201_4012713976726028288_o.jpg?_nc_cat=109&_nc_oc=AQlSsxr7ocJQdJ_USDptWwC1yYaFJvmQcqU1h1os4Kf4OXE8xOGfJWdUvVwrGyxSXYQ&_nc_ht=scontent-den4-1.xx&oh=b38ee308df03b9d760c5e720905eda0b&oe=5E4D6B16",
                        name: 'Paul Spudd',
                        description: "His face is squishy!",
                        approximate_age: 4,
                        sex: 'Male')

    visit "/pets/#{pet.id}"

    click_button "Add #{pet.name} to Favorites"
    visit '/favorites'

    within "#favorited_pet-#{pet.id}" do
      expect(page).to have_content(pet.name)
    end

    within 'nav' do
      expect(page).to have_content("Favorites: 1")
    end

    visit "/pets/#{pet.id}"
    click_link "Delete #{pet.name}"

    within 'nav' do
      expect(page).to have_content("Favorites: 0")
    end

    visit '/favorites'
    expect(page).to_not have_content(pet.name)
  end
end
