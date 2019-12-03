require 'rails_helper'

RSpec.describe "when I visit a shelter show page" do
  describe "as a visitor" do
    describe "when I click on a link to delete the shelter" do
      before :each do
        @shelter_1 = Shelter.create(name: "Gimme Shelter", address: "5218 Rolling Stones Avenue", city: "Denver", state: "CO", zip: 80203)
      end
      it "I can delete a shelter without pets" do

        visit "/shelters/#{@shelter_1.id}"
        click_link "Delete #{@shelter_1.name}"

        expect(current_path).to eq('/shelters')
        expect(page).to_not have_content(@shelter_1.name)
      end

      it "I can delete a shelter with pets and simultaneously delete all of its pets" do
        pet_1 = @shelter_1.pets.create!(name: "Pet 1", image: "https://www.certapet.com/wp-content/uploads/2019/05/shutterstock_561362863.jpg", description: "It's pet #1.", approximate_age: 5, sex: "Female")
        pet_2 = @shelter_1.pets.create!(name: "Pet 2", image: "https://www.certapet.com/wp-content/uploads/2019/05/shutterstock_561362863.jpg", description: "It's pet #2.", approximate_age: 2, sex: "Male")
        pet_3 = @shelter_1.pets.create!(name: "Pet 3", image: "https://www.certapet.com/wp-content/uploads/2019/05/shutterstock_561362863.jpg", description: "It's pet #3.", approximate_age: 1, sex: "Female")

        visit "/shelters/#{@shelter_1.id}"
        click_link "Delete #{@shelter_1.name}"

        expect(current_path).to eq('/shelters')
        expect(page).to_not have_content(@shelter_1.name)

        visit "/pets"
        expect(page).to_not have_content(pet_1.name)
        expect(page).to_not have_content(pet_2.name)
        expect(page).to_not have_content(pet_3.name)
      end
    end
  end
end
