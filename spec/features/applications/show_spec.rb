require 'rails_helper'

RSpec.describe "When I visit an application's show page" do
  it "I can see the following
  - name
  - address
  - city
  - state
  - zip
  - phone number
  - Description of why the applicant says they'd be a good home for this pet(s)
  - names of all pet's that this application is for (all names of pets should be links to their show page)" do

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
    application = Application.create!(name: "I'm just searching for a new best friend",
                                  address: "1703 11th Ave",
                                  city:"Boulder" ,
                                  state: "CO",
                                  zip: 80423,
                                  phone_number: 3036077527,
                                  description: "I need an adventure buddy")

    pet_1.applications << application
    pet_2.applications << application

    visit "/applications/#{application.id}"

    within "#application_contents-#{application.id}" do
      expect(page).to have_content(application.name)
      expect(page).to have_content(application.address)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(application.zip)
      expect(page).to have_content(application.phone_number)
      expect(page).to have_content(application.description)
    end

    within "#pets_applied_for-#{pet_1.id}" do
      click_link "#{pet_1.name}"
    end

    expect(current_path).to eq("/pets/#{pet_1.id}")

    visit "/applications/#{application.id}"

    within "#pets_applied_for-#{pet_2.id}" do
      click_link "#{pet_2.name}"
    end

    expect(current_path).to eq("/pets/#{pet_2.id}")
  end
end
