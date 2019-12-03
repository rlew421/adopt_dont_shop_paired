require 'rails_helper'

describe "shelter index page" do
  describe "as a visitor" do
    before :each do
      @shelter_1 = Shelter.create!(name: "Gimme Shelter", address: "5218 Rolling Stones Avenue", city: "Denver", state: "CO", zip: 80203)
      @shelter_2 = Shelter.create!(name: "Boulder Bulldog Rescue", address: "2712 Slobber Circle", city: "Boulder", state: "CO", zip: 80205)
      @shelter_3 = Shelter.create!(name: "Howlz 'n Jowlz", address: "7943 Furry Friend Drive", city: "Colorado Springs", state: "CO", zip: 80207)

      visit '/shelters'
    end
    it "I see the name of each shelter in the system as a link to the shelter's show page" do
      expect(page).to have_link(@shelter_1.name)
      expect(page).to have_link(@shelter_2.name)
      expect(page).to have_link(@shelter_3.name)

      click_on "#{@shelter_3.name}"
      expect(current_path).to eq("/shelters/#{@shelter_3.id}")
    end

    it "I see an edit link next to each shelter that allows me to edit the shelter through the edit form" do
      within "#shelter-#{@shelter_1.id}" do
        expect(page).to have_link("Edit #{@shelter_1.name}")
      end
      click_link "Edit #{@shelter_1.name}"
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")

      visit '/shelters'

      within "#shelter-#{@shelter_2.id}" do
        expect(page).to have_link("Edit #{@shelter_2.name}")
      end
      click_link "Edit #{@shelter_2.name}"
      expect(current_path).to eq("/shelters/#{@shelter_2.id}/edit")
    end

    it "I see a delete link next to each shelter that allows me to delete the shelter" do
      within "#shelter-#{@shelter_1.id}" do
        expect(page).to have_link("Delete #{@shelter_1.name}")
      end
      click_link "Delete #{@shelter_1.name}"
      expect(current_path).to eq('/shelters')
      expect(page).to_not have_content(@shelter_1.name)

      visit '/shelters'

      within "#shelter-#{@shelter_2.id}" do
        expect(page).to have_link("Delete #{@shelter_2.name}")
      end
      click_link "Delete #{@shelter_2.name}"
      expect(current_path).to eq('/shelters')
      expect(page).to_not have_content(@shelter_2.name)
    end
  end
end
