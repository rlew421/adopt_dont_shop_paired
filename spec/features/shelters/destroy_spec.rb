require 'rails_helper'

RSpec.describe "when I visit a shelter show page" do
  describe "as a visitor" do
    describe "when I click on a link to delete the shelter" do
      before :each do
        @shelter_1 = Shelter.create(name: "Gimme Shelter", address: "5218 Rolling Stones Avenue", city: "Denver", state: "CO", zip: 80203)
        @review_1 = @shelter_1.reviews.create!(title: "Perfectly adequate", rating: 3, content: "Run of the mill shelter")
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

        expect(Review.count).to eql(1)

        visit "/shelters/#{@shelter_1.id}"
        click_link "Delete #{@shelter_1.name}"

        expect(current_path).to eq('/shelters')
        expect(page).to_not have_content(@shelter_1.name)

        visit "/pets"
        expect(page).to_not have_content(pet_1.name)
        expect(page).to_not have_content(pet_2.name)
        expect(page).to_not have_content(pet_3.name)
        expect(Review.count).to eql(0)
      end

      it "I cannot delete a shelter with pets whose adoption status is pending" do
        pet_1 = @shelter_1.pets.create!( image: "https://i.pinimg.com/564x/59/71/31/5971314eb28926a1ccc298396f099189.jpg",
                                        name: 'Simba',
                                        description: "Pet 1 description",
                                        approximate_age: 5,
                                        sex: 'Male')

        application_1 = pet_1.applications.create!( name: "James Earl Jones",
                                                  address: "1703 11th Ave",
                                                  city:"Boulder" ,
                                                  state: "CO",
                                                  zip: 80423,
                                                  phone_number: 3036077527,
                                                  description: "I need an adventure buddy")

        application_2 = pet_1.applications.create!( name: "John Doe",
                                                  address: "9827 Denver Drive",
                                                  city:"Denver" ,
                                                  state: "CO",
                                                  zip: 80204,
                                                  phone_number: 2938193029,
                                                  description: "Looking for a furry friend")

        visit "/applications/#{application_1.id}"
        within "#pets_applied_for-#{pet_1.id}" do
          click_link "Approve Application For #{pet_1.name}"
        end

        visit "/shelters/#{@shelter_1.id}"
        expect(page).to_not have_link("Delete #{@shelter_1.name}")

        visit "/shelters"
        within "#shelter-#{@shelter_1.id}" do
          expect(page).to_not have_link("Delete #{@shelter_1.name}")
        end
      end
    end
  end
end
