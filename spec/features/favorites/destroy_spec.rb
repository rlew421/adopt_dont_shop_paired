require 'rails_helper'

RSpec.describe "when I visit the show page of a pet I've favorited" do
  it "I no longer see a link to favorite that pet but instead see a link that removes that pet from favorites" do
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

    visit "/pets/#{pet_1.id}"

    within 'nav' do
      expect(page).to have_content("Favorites: 0")
    end
    click_button "Add #{pet_1.name} to Favorites"

    within 'nav' do
      expect(page).to have_content("Favorites: 1")
    end

    visit "/pets/#{pet_2.id}"
    click_button "Add #{pet_2.name} to Favorites"
    expect(page).to have_content("Favorites: 2")

    visit "/pets/#{pet_1.id}"
    expect(page).to_not have_button("Add #{pet_1.name} to Favorites")
    click_button "Remove #{pet_1.name} from Favorites"

    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).to have_content("#{pet_1.name} has been removed from your favorites!")
    expect(page).to have_button("Add #{pet_1.name} to Favorites")

    within 'nav' do
      expect(page).to have_content("Favorites: 1")
    end
  end
end
