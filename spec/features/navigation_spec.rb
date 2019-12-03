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
  end
end
