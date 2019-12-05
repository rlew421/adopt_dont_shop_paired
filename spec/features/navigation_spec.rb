require 'rails_helper'

RSpec.describe 'site top navigation bar' do
  describe 'as a visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/shelters'
      within 'nav' do
        click_link 'All Pets'
      end

      expect(current_path).to eq('/pets')
      within 'nav' do
        click_link 'All Shelters'
      end

      expect(current_path).to eq('/shelters')
    end

    it "I can see a favorites indicator on all pages" do
      visit '/shelters'

      within 'nav' do
        expect(page).to have_content("Favorites: 0")
      end

      visit '/pets'

      within 'nav' do
        expect(page).to have_content("Favorites: 0")
      end
    end
  end
end
