require 'rails_helper'

describe "Every pet that the application is for has a link next to it to approve the application for that pet" do
  it "when I click the approve application link it takes me to the pets show page and I can see
  - the pets status changes to 'pending
  - it shows who the pet is on hold for" do

  shelter_1 = Shelter.create!(name: "Denver Dog Shelter", address: "7893 Colfax", city: "Denver", state: "CO", zip: 80209)
  pet_1 = shelter_1.pets.create!( image: "https://i.pinimg.com/564x/59/71/31/5971314eb28926a1ccc298396f099189.jpg",
                                  name: 'Simba',
                                  description: "Pet 1 description",
                                  approximate_age: 5,
                                  sex: 'Male')
  pet_2 = shelter_1.pets.create!( image: "https://slack-imgs.com/?c=1&o1=ro&url=https%3A%2F%2Fi.pinimg.com%2F564x%2Fc4%2F3e%2F7f%2Fc43e7f6a45aba8790a8c47d3a5d62ee8.jpg",
                                  name: 'Pet 2',
                                  description: "Pet 2 desc",
                                  approximate_age: 3,
                                  sex: 'Female')
  application = pet_1.applications.create!( name: "James Earl Jones",
                                            address: "1703 11th Ave",
                                            city:"Boulder" ,
                                            state: "CO",
                                            zip: 80423,
                                            phone_number: 3036077527,
                                            description: "I need an adventure buddy")
  application.pets << pet_2

  visit "/applications/#{application.id}"

  within "#pets_applied_for-#{pet_1.id}" do
    expect(page).to have_content("Approve Application For #{pet_1.name}")
  end
  within "#pets_applied_for-#{pet_2.id}" do
    expect(page).to have_content("Approve Application For #{pet_2.name}")
  end

  within "#pets_applied_for-#{pet_1.id}" do
    click_link "Approve Application For #{pet_1.name}"
  end

  expect(current_path).to eq("/pets/#{pet_1.id}")
  expect(page).to have_content("Status: Pending")
  expect(page).to have_content("On hold for #{application.name}")
  end
end