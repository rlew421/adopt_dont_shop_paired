# User Story 19, Application Show Page
#
# As a visitor
# When I visit an applications show page "/applications/:id"
# I can see the following:
# - name
# - address
# - city
# - state
# - zip
# - phone number
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pet's that this application is for (all names of pets should be links to their show page)

require 'rails_helper'

RSpec.describe "When I visit an applications show page" do
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
  application = pet_1.applications.create!(name: "I'm just searching for a new best friend",
                                address: "1703 11th Ave",
                                city:"Boulder" ,
                                state: "CO",
                                zip: 80423,
                                phone_number: 3036077527,
                                description: "I need an adventure buddy")

  visit "/applications/#{application.id}"

  within "#application_contents-#{application.id}"
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
    expect(page).to have_content(application.phone_number)
    expect(page).to have_content(application.description)
  end
end
