require 'rails_helper'

RSpec.describe "favorites index page" do
  it "I see all pets I've favorited along with:
  - a pet's name (links to pets show page
  - a pet's image)" do

    shelter_1 = Shelter.create!(name: "Denver Dog Shelter", address: "7893 Colfax", city: "Denver", state: "CO", zip: 80209)
    pet_1 = shelter_1.pets.create!(image: "https://i.pinimg.com/564x/59/71/31/5971314eb28926a1ccc298396f099189.jpg",
                        name: 'Pet 1',
                        description: "Pet 1 description",
                        approximate_age: 7,
                        sex: 'Male')

    pet_2 = shelter_1.pets.create!(image: "https://i.pinimg.com/564x/59/71/31/5971314eb28926a1ccc298396f099189.jpg",
                        name: 'Pet 2',
                        description: "Pet 2 description",
                        approximate_age: 2,
                        sex: 'Female')

    pet_3 = shelter_1.pets.create!(image: "https://vetstreet.brightspotcdn.com/dims4/default/3407f3b/2147483647/thumbnail/645x380/quality/90/?url=https%3A%2F%2Fvetstreet-brightspot.s3.amazonaws.com%2Ffb%2F31%2F032a6aae436a9821acda211044fb%2Fbulldog-ap-rn4myi-645.jpg",
                        name: 'Pet 3',
                        description: "Pet 2 description",
                        approximate_age: 4,
                        sex: 'Male')

    visit "/pets/#{pet_1.id}"
    click_button "Add #{pet_1.name} to Favorites"

    visit "/pets/#{pet_2.id}"
    click_button "Add #{pet_2.name} to Favorites"

    visit '/favorites'

    expect(page).to have_content(pet_1.name)
    expect(page).to have_css("img[src*='#{pet_1.image}']")
    expect(page).to have_content(pet_2.name)
    expect(page).to have_css("img[src*='#{pet_2.image}']")
    expect(page).to_not have_content(pet_3.name)
    expect(page).to_not have_css("img[src*='#{pet_3.image}']")
  end
  it "clicking on the favorites indicator in the navbar of any page directs me to the favorites index" do
    visit "/pets"
    click_button "Favorites"
    expect(current_path).to eq("/favorites")

    visit "/shelters"
    click_button "Favorites"
    expect(current_path).to eq("/favorites")

    visit "/shelters/pets"
    click_button "Favorites"
    expect(current_path).to eq("/favorites")
  end
end
