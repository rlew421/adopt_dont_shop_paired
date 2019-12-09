# As a visitor
# When I have added pets to my favorites list
# And I visit my favorites page ("/favorites")
# I see a link for adopting my favorited pets
# When I click that link I'm taken to a new application form
# At the top of the form, I can select from the pets of which I've favorited for which I'd like this application to apply towards (can be more than one)
# When I select one or more pets, and fill in my
# - Name
# - Address
# - City
# - State
# - Zip
# - Phone Number
# - Description of why I'd make a good home for this/these pet(s)
# And I click on a button to submit my application
# I see a flash message indicating my application went through for the pets that were selected
# And I'm taken back to my favorites page where I no longer see the pets for which I just applied listed as favorites

require 'rails_helper'

RSpec.describe "when I visit my favorites page" do
  it "I can click a link to a new application form that creates an application for selected pets" do
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
    pet_3 = shelter_1.pets.create!(image: "https://vetstreet.brightspotcdn.com/dims4/default/3407f3b/2147483647/thumbnail/645x380/quality/90/?url=https%3A%2F%2Fvetstreet-brightspot.s3.amazonaws.com%2Ffb%2F31%2F032a6aae436a9821acda211044fb%2Fbulldog-ap-rn4myi-645.jpg",
                        name: 'Pet 3',
                        description: "Pet 2 description",
                        approximate_age: 4,
                        sex: 'Male')

    visit "/pets/#{pet_1.id}"
    click_button "Add #{pet_1.name} to Favorites"

    visit "/pets/#{pet_2.id}"
    click_button "Add #{pet_2.name} to Favorites"

    visit "/pets/#{pet_3.id}"
    click_button "Add #{pet_3.name} to Favorites"

    visit '/favorites'

    click_link "Apply to Adopt Pets"
    expect(current_path).to eq('/applications/new')

    within "#favorite-#{pet_1.id}" do
      check("#{pet_1.name}")
    end

    check(pet_1.name)

    within "#favorite-#{pet_2.id}" do
      check("#{pet_2.name}")
    end

    check(pet_2.name)

    # within "#pet-#{pet_1.id}" do
    #   expect(page).to have_content(pet_1.name)
    #   expect(page).to have_checked_field('pet_1', checked: true)
    # end
    #
    # within "#pet-#{pet_2.id}" do
    #   expect(page).to have_content(pet_2.name)
    #   expect(page).to have_checked_field('pet_2', checked: true)
    # end
    #
    # within "#pet-#{pet_3.id}" do
    #   expect(page).to have_content(pet_3.name)
    #   expect(page).to have_unchecked_field('pet_3', unchecked: true)
    # end

    fill_in :name, with: "John Doe"
    fill_in :address, with: "1703 11th Ave"
    fill_in :city, with: "Boulder"
    fill_in :state, with: "CO"
    fill_in :zip, with: 80423
    fill_in :phone_number, with: 7209305236
    fill_in :description, with: "I'm just searching for a new best friend"

    click_button "Submit Application"

    expect(page).to have_content "Your application has been submitted for the selected pets!"
    expect(current_path).to eq('/favorites')
    save_and_open_page
    expect(page).to_not have_content(pet_1.name)
    expect(page).to_not have_css("img[src*='#{pet_1.image}']")
    expect(page).to_not have_content(pet_2.name)
    expect(page).to_not have_css("img[src*='#{pet_2.image}']")
    expect(page).to have_content(pet_3.name)
    expect(page).to have_css("img[src*='#{pet_3.image}']")
  end
end
