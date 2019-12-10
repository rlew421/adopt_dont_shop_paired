require 'rails_helper'

# User Story 23, Users can get approved to adopt more than one pet
#
# As a visitor
# When an application is made for more than one pet
# When I visit that applications show page
# I'm able to approve the application for any number of pets

RSPec.describe "After an application is made for multiple pets, and when I visit that applications show page" do
  xit "I'm able to approve the application for any number of pets" do
    shelter_1 = Shelter.create!(name: "Denver Dog Shelter", address: "7893 Colfax", city: "Denver", state: "CO", zip: 80209)
    pet_1 = shelter_1.pets.create!( image: "https://i.pinimg.com/564x/59/71/31/5971314eb28926a1ccc298396f099189.jpg",
                                    name: 'Pet 1',
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



  end
end
