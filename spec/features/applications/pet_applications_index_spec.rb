require 'rails_helper'

RSpec.describe "pet applications index page" do
  describe "when I visit a pet's show page" do
    it "I can click a link to view all applications for this pet which takes me to a list where:
    - I see all names of applicants for this pet
    - Each applicant's name is a link to their application show page" do

      shelter_1 = Shelter.create!(name: "Denver Dog Shelter", address: "7893 Colfax", city: "Denver", state: "CO", zip: 80209)
      pet_1 = shelter_1.pets.create!(image: "https://i.pinimg.com/564x/59/71/31/5971314eb28926a1ccc298396f099189.jpg",
                          name: 'Pet 1',
                          description: "Pet 1 description",
                          approximate_age: 7,
                          sex: 'Male')


      visit "/pets/#{pet_1.id}"
      click_button "Add #{pet_1.name} to Favorites"

      visit '/favorites'

      click_link "Apply to Adopt Pets"

      within "#favorite-#{pet_1.id}" do
        check("favorites[]")
      end

      fill_in :name, with: "John Doe"
      fill_in :address, with: "1703 11th Ave"
      fill_in :city, with: "Boulder"
      fill_in :state, with: "CO"
      fill_in :zip, with: 80423
      fill_in :phone_number, with: 7209305236
      fill_in :description, with: "I'm just searching for a new best friend"

      click_button "Submit Application"
      application = Application.last
      expect(application.name).to eq("John Doe")

      visit "/pets/#{pet_1.id}"
      click_button "Add #{pet_1.name} to Favorites"

      visit '/favorites'

      click_link "Apply to Adopt Pets"

      within "#favorite-#{pet_1.id}" do
        check("favorites[]")
      end

      fill_in :name, with: "Jane Doe"
      fill_in :address, with: "1904 12th Ave"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: 80204
      fill_in :phone_number, with: 8729718293
      fill_in :description, with: "I would be a great dog parent."

      click_button "Submit Application"
      application_2 = Application.last
      expect(application_2.name).to eq("Jane Doe")

      visit "/pets/#{pet_1.id}"
      click_link "View all applications for #{pet_1.name}"

      within "#application-#{application.id}" do
        click_link "#{application.name}"
      end

      expect(current_path).to eq("/applications/#{application.id}")

      visit "/pets/#{pet_1.id}"
      click_link "View all applications for #{pet_1.name}"

      within "#application-#{application_2.id}" do
        click_link "#{application_2.name}"
      end

      expect(current_path).to eq("/applications/#{application_2.id}")
    end

    it "When I visit a pet applications index page for a pet that has no applicaitons on them I see a message saying there are no applications for this pet" do
      shelter_1 = Shelter.create!(name: "Denver Dog Shelter", address: "7893 Colfax", city: "Denver", state: "CO", zip: 80209)
      pet_1 = shelter_1.pets.create!(image: "https://i.pinimg.com/564x/59/71/31/5971314eb28926a1ccc298396f099189.jpg",
                          name: 'Pet 1',
                          description: "Pet 1 description",
                          approximate_age: 7,
                          sex: 'Male')

      pet_2 = shelter_1.pets.create!(image: "https://thumbs-prod.si-cdn.com/wLrciMDDerMdsUZS8GZwduuMvPs=/420x240/filters:focal(274x157:275x158)/https://public-media.si-cdn.com/filer/ca/15/ca15e676-bfa1-4180-ae4b-02797b55c093/gettyimages-511711532_720.jpg",
                          name: 'Pet 2',
                          description: "Pet 2 description",
                          approximate_age: 2,
                          sex: 'Female')

      visit "/pets/#{pet_1.id}"
      click_button "Add #{pet_1.name} to Favorites"

      visit "/pets/#{pet_1.id}"
      click_link "View all applications for #{pet_1.name}"
      expect(current_path).to eq("/pets/#{pet_1.id}/applications")
      expect(page).to have_content("No one has applied for this pet!")

      visit "/pets/#{pet_2.id}"
      click_link "View all applications for #{pet_2.name}"
      expect(current_path).to eq("/pets/#{pet_2.id}/applications")
      expect(page).to have_content("No one has applied for this pet!")
    end
  end
end
