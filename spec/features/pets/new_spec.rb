require 'rails_helper'

RSpec.describe "shelter pet creation" do
  describe "as a visitor" do
    it "I can click a link from the shelter pets index page and fill out a form to add a new adoptable pet" do
      boulder_bulldog_rescue = Shelter.create(name: "Boulder Bulldog Rescue", address: "2712 Slobber Circle", city: "Boulder", state: "CO", zip: 80205)

      visit "/shelters/#{boulder_bulldog_rescue.id}/pets"
      click_link "Add New Adoptable Pet"

      expect(current_path).to eq("/shelters/#{boulder_bulldog_rescue.id}/pets/new")

      image = "https://i.pinimg.com/564x/ea/ce/e2/eacee2bd58b66e2367e59c10e46e8623.jpg"
      name = "T-Bone"
      description = "After being abandoned by my owner, I'm looking for my furever home! Aren't I adora-bull?"
      approximate_age = 6
      sex = "Male"

      fill_in :image, with: image
      fill_in :name, with: name
      fill_in :description, with: description
      fill_in :approximate_age, with: approximate_age
      fill_in :sex, with: sex
      click_button "Create New Adoptable Pet"

      new_pet = Pet.last

      expect(current_path).to eq("/shelters/#{boulder_bulldog_rescue.id}/pets")
      expect(new_pet.image).to eq(image)
      expect(new_pet.name).to eq(name)
      expect(new_pet.description).to eq(description)
      expect(new_pet.approximate_age).to eq(approximate_age)
      expect(new_pet.sex).to eq(sex)
      expect(Pet.last.adoptable?).to be(true)

      within "#pet-#{new_pet.id}" do
        expect(page).to have_css("img[src*='#{new_pet.image}']")
        expect(page).to have_content(new_pet.name)
        expect(page).to have_content(new_pet.approximate_age)
        expect(page).to have_content(new_pet.sex)
      end
    end
  end
end
