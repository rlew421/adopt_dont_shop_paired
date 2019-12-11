require 'rails_helper'

RSpec.describe "when I visit shelter index page" do
  it "I see a link to create a new shelter" do
    visit '/shelters'

    expect(page).to have_link("Add New Shelter")
  end

  it "I can click on the link and fill out a form to create a new shelter" do
    visit '/shelters'
    click_link "Add New Shelter"

    expect(current_path).to eq('/shelters/new')
    fill_in :name, with: "Rover Oaks Pet Resort"
    fill_in :address, with: "2550 W Bellfort Blvd"
    fill_in :city, with: "Houston"
    fill_in :state, with: "TX"
    fill_in :zip, with: 77054
    click_button "Create New Shelter"

    expect(page).to have_content "Shelter has been created!"
    expect(current_path).to eq('/shelters')
    expect(page).to have_content("Rover Oaks Pet Resort")
  end

  it "When I fail to fill out all fields I receive a flash message telling me which fields must be filled in" do
    visit '/shelters'
    click_link "Add New Shelter"

    expect(current_path).to eq('/shelters/new')
    fill_in :name, with: "Rover Oaks Pet Resort"
    fill_in :address, with: "2550 W Bellfort Blvd"
    fill_in :city, with: "Houston"
    fill_in :zip, with: 77054
    click_button "Create New Shelter"

    expect(page).to have_content "State can't be blank"
    expect(current_path).to eq('/shelters/new')
  end
end
