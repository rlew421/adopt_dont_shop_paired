require 'rails_helper'

RSpec.describe "shelter pets index page" do
  describe "as a visitor" do
    before(:each) do
      @boulder_bulldog_rescue = Shelter.create(name: "Boulder Bulldog Rescue", address: "2712 Slobber Circle", city: "Boulder", state: "CO", zip: 80205)
      @howlz_n_jowlz = Shelter.create(name: "Howlz 'n Jowlz", address: "7943 Furry Friend Drive", city: "Colorado Springs", state: "CO", zip: 80207)

      @pet_1 = @boulder_bulldog_rescue.pets.create(image: "https://scontent-den4-1.xx.fbcdn.net/v/t1.0-9/69959835_377201229643201_4012713976726028288_o.jpg?_nc_cat=109&_nc_oc=AQlSsxr7ocJQdJ_USDptWwC1yYaFJvmQcqU1h1os4Kf4OXE8xOGfJWdUvVwrGyxSXYQ&_nc_ht=scontent-den4-1.xx&oh=b38ee308df03b9d760c5e720905eda0b&oe=5E4D6B16",
        name: 'Henri',
        description: "With his heartwarming wrinkles and furrowed brow, he'll slobber his way into your heart!",
        approximate_age: 5,
        sex: 'Male')

      @pet_2 = @howlz_n_jowlz.pets.create(image: "https://scontent-den4-1.xx.fbcdn.net/v/t31.0-8/14608760_10153942326162816_2748710450820779939_o.jpg?_nc_cat=100&_nc_oc=AQnrfoKEaHR6I5dtefDwT7AGx_jSyJbGEabXvtbS9jMf2eGvl4_plvsK3eSmKjECppM&_nc_ht=scontent-den4-1.xx&oh=358dd965255af229bdc5ea8bb5090fca&oe=5E4AA5BB",
        name: 'Alfred',
        description: "Truly a beautiful wrinkly boi!",
        approximate_age: 10,
        sex: 'Male')

      @pet_3 = @boulder_bulldog_rescue.pets.create(image: "https://i.pinimg.com/564x/4b/0c/99/4b0c99ace72fdfc65b2853fa14d41a8b.jpg",
        name: 'Toast',
        description: "She snorts, she farts, she's sweeter than French toast!",
        approximate_age: 4,
        sex: 'Female')

      @pet_4= @boulder_bulldog_rescue.pets.create(image: "https://slack-imgs.com/?c=1&o1=ro&url=https%3A%2F%2Fi.pinimg.com%2F564x%2Fc4%2F3e%2F7f%2Fc43e7f6a45aba8790a8c47d3a5d62ee8.jpg",
        name: 'Botox',
        description: 'So wrinkly!',
        approximate_age: 7,
        sex: 'Female',
        adoptable?: false)

      @pet_5 = @boulder_bulldog_rescue.pets.create!(image: "https://i.pinimg.com/564x/fa/f0/f1/faf0f151c420f2451bcd583de153c38b.jpg",
        name: 'Pumbaa',
        description: 'So wrinkly!',
        approximate_age: 3,
        sex: 'Male',
        adoptable?: false)

      @pet_6 = @boulder_bulldog_rescue.pets.create!(image: "https://i.pinimg.com/564x/07/34/10/0734102786dfa61651d5378a17476af6.jpg",
          name: 'Winston',
          description: "Truly a beautiful wrinkly boi!",
          approximate_age: 8,
          sex: 'Male')

      visit "/shelters/#{@boulder_bulldog_rescue.id}/pets"
    end

    it "I see each pet that can be adopted from that shelter with that shelter_id including the pet's:
    - image
    - name
    - approximate age
    - sex " do

      within "#pet-#{@pet_1.id}" do
        expect(page).to have_css("img[src*='#{@pet_1.image}']")
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@pet_1.approximate_age)
        expect(page).to have_content(@pet_1.sex)
        expect(page).to_not have_content(@pet_1.shelter.name)
      end

      within "#pet-#{@pet_3.id}" do
        expect(page).to have_css("img[src*='#{@pet_3.image}']")
        expect(page).to have_content(@pet_3.name)
        expect(page).to have_content(@pet_3.approximate_age)
        expect(page).to have_content(@pet_3.sex)
        expect(page).to_not have_content(@pet_3.shelter.name)
      end

      expect(page).to_not have_css("img[src*='#{@pet_2.image}']")
      expect(page).to_not have_content(@pet_2.name)
      expect(page).to_not have_content(@pet_2.approximate_age)
      expect(page).to_not have_content(@pet_2.shelter.name)
    end

    it "I can click on the the name of the pet in a shelter and navigate to that pet's show page" do
      within "#pet-#{@pet_1.id}" do
        click_link "#{@pet_1.name}"
      end

      expect(current_path).to eq("/shelters/#{@boulder_bulldog_rescue.id}/pets/#{@pet_1.id}")

      visit "/shelters/#{@boulder_bulldog_rescue.id}/pets"

      within "#pet-#{@pet_3.id}" do
        click_link "#{@pet_3.name}"
      end

      expect(current_path).to eq("/shelters/#{@boulder_bulldog_rescue.id}/pets/#{@pet_3.id}")
    end

    it "I see an edit link next to each pet that allows me to edit that pet's information through the edit form" do
      within "#pet-#{@pet_1.id}" do
        expect(page).to have_link("Edit")
        click_link "Edit"
      end
      expect(current_path).to eq("/shelters/#{@boulder_bulldog_rescue.id}/pets/#{@pet_1.id}/edit")

      visit "/shelters/#{@boulder_bulldog_rescue.id}/pets"

      within "#pet-#{@pet_3.id}" do
        expect(page).to have_link("Edit")
        click_link "Edit"
      end
      expect(current_path).to eq("/shelters/#{@boulder_bulldog_rescue.id}/pets/#{@pet_3.id}/edit")
    end

    it "I see a delete link next to each pet that allows me to delete that pet" do
      within "#pet-#{@pet_1.id}" do
        expect(page).to have_link("Delete")
        click_link "Delete"
      end
      expect(current_path).to eq("/pets")
      expect(page).to_not have_content(@pet_1.name)

      visit "/shelters/#{@boulder_bulldog_rescue.id}/pets"

      within "#pet-#{@pet_3.id}" do
        expect(page).to have_link("Delete")
        click_link "Delete"
      end
      expect(current_path).to eq("/pets")
      expect(page).to_not have_content(@pet_3.name)
    end

    it "I see a count of the number of pets at this shelter" do
      expect(page).to have_content("Number of Pets at #{@boulder_bulldog_rescue.name}: 5")
    end

    it "I see adoptable pets listed before pets whose adoption status is pending" do
      expect(page.find_all('.pets')[0]).to have_content("#{@pet_1.name}")
      expect(page.find_all('.pets')[1]).to have_content("#{@pet_3.name}")
      expect(page.find_all('.pets')[2]).to have_content("#{@pet_6.name}")
      expect(page.find_all('.pets')[3]).to have_content("#{@pet_4.name}")
      expect(page.find_all('.pets')[4]).to have_content("#{@pet_5.name}")
    end
  end
end
