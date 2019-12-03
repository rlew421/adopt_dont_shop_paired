require 'rails_helper'

RSpec.describe "shelter show page" do
  describe "as a visitor" do
    before(:each) do
      @shelter_1 = Shelter.create(name: "Gimme Shelter", address: "5218 Rolling Stones Avenue", city: "Denver", state: "CO", zip: 80203)

      visit "/shelters/#{@shelter_1.id}"
    end

    it "I see the shelter with that id including the shelter's:
      - name
      - address
      - city
      - state
      - zip" do


      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_1.address)
      expect(page).to have_content(@shelter_1.city)
      expect(page).to have_content(@shelter_1.state)
      expect(page).to have_content(@shelter_1.zip)
    end

    it "I see a link that takes me to that shelter's pets page" do
      click_link "View #{@shelter_1.name}'s Pets"
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
    end
  end
end
