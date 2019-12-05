require 'rails_helper'

RSpec.describe 'Favorite creation' do
  describe "When I visit a pet show page" do

    it "I see a link to favorite that pet and when I favorite that pet my favorites count increments" do
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

      expect(current_path).to eq("/pets/#{pet_1.id}")
      expect(page).to have_content("#{pet_1.name} has been added to your favorites!")

      within 'nav' do
        expect(page).to have_content("Favorites: 1")
      end

      visit "/pets/#{pet_2.id}"

      click_button "Add #{pet_2.name} to Favorites"

      expect(current_path).to eq("/pets/#{pet_2.id}")
      expect(page).to have_content("#{pet_2.name} has been added to your favorites!")

      within 'nav' do
        expect(page).to have_content("Favorites: 2")
      end
    end
  end
end
