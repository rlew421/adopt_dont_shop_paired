require 'rails_helper'

RSpec.describe "pets index page" do
  describe "as a visitor" do
    before(:each) do
      @boulder_bulldog_rescue = Shelter.create(name: "Boulder Bulldog Rescue", address: "2712 Slobber Circle", city: "Boulder", state: "CO", zip: 80205)
      @howlz_n_jowlz = Shelter.create(name: "Howlz 'n Jowlz", address: "7943 Furry Friend Drive", city: "Colorado Springs", state: "CO", zip: 80207)

      @botox = @boulder_bulldog_rescue.pets.create(image: "https://slack-imgs.com/?c=1&o1=ro&url=https%3A%2F%2Fi.pinimg.com%2F564x%2Fc4%2F3e%2F7f%2Fc43e7f6a45aba8790a8c47d3a5d62ee8.jpg",
        name: 'Botox',
        description: 'So wrinkly!',
        approximate_age: 7,
        sex: 'Female',
        adoptable?: false)

      @henri = @boulder_bulldog_rescue.pets.create(image: "https://scontent-den4-1.xx.fbcdn.net/v/t1.0-9/69959835_377201229643201_4012713976726028288_o.jpg?_nc_cat=109&_nc_oc=AQlSsxr7ocJQdJ_USDptWwC1yYaFJvmQcqU1h1os4Kf4OXE8xOGfJWdUvVwrGyxSXYQ&_nc_ht=scontent-den4-1.xx&oh=b38ee308df03b9d760c5e720905eda0b&oe=5E4D6B16",
        name: 'Henri',
        description: "With his heartwarming wrinkles and furrowed brow, he'll slobber his way into your heart!",
        approximate_age: 5,
        sex: 'Male')

      @alfred = @howlz_n_jowlz.pets.create(image: "https://scontent-den4-1.xx.fbcdn.net/v/t31.0-8/14608760_10153942326162816_2748710450820779939_o.jpg?_nc_cat=100&_nc_oc=AQnrfoKEaHR6I5dtefDwT7AGx_jSyJbGEabXvtbS9jMf2eGvl4_plvsK3eSmKjECppM&_nc_ht=scontent-den4-1.xx&oh=358dd965255af229bdc5ea8bb5090fca&oe=5E4AA5BB",
        name: 'Alfred',
        description: "Truly a beautiful wrinkly boi!",
        approximate_age: 2,
        sex: 'Male')

      @pumbaa = @boulder_bulldog_rescue.pets.create!(image: "https://slack-imgs.com/?c=1&o1=ro&url=https%3A%2F%2Fi.pinimg.com%2F564x%2Fc4%2F3e%2F7f%2Fc43e7f6a45aba8790a8c47d3a5d62ee8.jpg",
        name: 'Pumbaa',
        description: 'So wrinkly!',
        approximate_age: 3,
        sex: 'Male',
        adoptable?: false)

      @winston = @howlz_n_jowlz.pets.create!(image: "https://scontent-den4-1.xx.fbcdn.net/v/t31.0-8/14608760_10153942326162816_2748710450820779939_o.jpg?_nc_cat=100&_nc_oc=AQnrfoKEaHR6I5dtefDwT7AGx_jSyJbGEabXvtbS9jMf2eGvl4_plvsK3eSmKjECppM&_nc_ht=scontent-den4-1.xx&oh=358dd965255af229bdc5ea8bb5090fca&oe=5E4AA5BB",
          name: 'Winston',
          description: "Truly a beautiful wrinkly boi!",
          approximate_age: 8,
          sex: 'Male')

      visit '/pets'
    end

    it "I see each pet in the system including the pet's:
    - image
    - name
    - approximate age
    - sex
    - name of the shelter where the pet is currently located" do
      within "#pet-#{@henri.id}" do
        expect(page).to have_css("img[src*='#{@henri.image}']")
        expect(page).to have_content("Name: #{@henri.name}")
        expect(page).to have_content("Age: #{@henri.approximate_age}")
        expect(page).to have_content("Sex: #{@henri.sex}")
        expect(page).to have_content("Current Shelter: #{@henri.shelter.name}")
      end

      within "#pet-#{@alfred.id}" do
        expect(page).to have_css("img[src*='#{@alfred.image}']")
        expect(page).to have_content("Name: #{@alfred.name}")
        expect(page).to have_content("Age: #{@alfred.approximate_age}")
        expect(page).to have_content("Sex: #{@alfred.sex}")
        expect(page).to have_content("Current Shelter: #{@alfred.shelter.name}")
      end

      within "#pet-#{@botox.id}" do
        expect(page).to have_css("img[src*='#{@botox.image}']")
        expect(page).to have_content("Name: #{@botox.name}")
        expect(page).to have_content("Age: #{@botox.approximate_age}")
        expect(page).to have_content("Sex: #{@botox.sex}")
        expect(page).to have_content("Current Shelter: #{@botox.shelter.name}")
      end
    end

    it "I can click on the the name of the pet's shelter and navigate to that shelter's show page" do
      within "#pet-#{@henri.id}" do
        expect(page).to have_link("#{@henri.shelter.name}")
        click_link "#{@henri.shelter.name}"
      end

      expect(current_path).to eq("/shelters/#{@boulder_bulldog_rescue.id}")

      visit '/pets'

      within "#pet-#{@alfred.id}" do
        expect(page).to have_link("#{@alfred.shelter.name}")
        click_link "#{@alfred.shelter.name}"
      end

      expect(current_path).to eq("/shelters/#{@howlz_n_jowlz.id}")

      visit '/pets'

      within "#pet-#{@botox.id}" do
        expect(page).to have_link("#{@botox.shelter.name}")
        click_link "#{@botox.shelter.name}"
      end

      expect(current_path).to eq("/shelters/#{@boulder_bulldog_rescue.id}")
    end

    it "I can click on the the name of the pet and navigate to that pet's show page" do
      within "#pet-#{@henri.id}" do
        click_link "#{@henri.name}"
      end

      expect(current_path).to eq("/pets/#{@henri.id}")

      visit '/pets'

      within "#pet-#{@alfred.id}" do
        click_link "#{@alfred.name}"
      end

      expect(current_path).to eq("/pets/#{@alfred.id}")

      visit '/pets'

      within "#pet-#{@botox.id}" do
        click_link "#{@botox.name}"
      end

      expect(current_path).to eq("/pets/#{@botox.id}")
    end

    it "I see an edit link next to each pet that allows me to edit that pet's information through the edit form" do
      within "#pet-#{@henri.id}" do
        click_link "Edit"
      end
      expect(current_path).to eq("/pets/#{@henri.id}/edit")

      visit '/pets'

      within "#pet-#{@alfred.id}" do
        click_link "Edit"
      end
      expect(current_path).to eq("/pets/#{@alfred.id}/edit")

      visit '/pets'

      within "#pet-#{@botox.id}" do
        click_link "Edit"
      end
      expect(current_path).to eq("/pets/#{@botox.id}/edit")
    end

    it "I see a delete link next to each pet that allows me to delete that pet" do
      within "#pet-#{@henri.id}" do
        click_link "Delete"
      end
      expect(current_path).to eq("/pets")
      expect(page).to_not have_content(@henri.name)

      visit '/pets'

      within "#pet-#{@alfred.id}" do
        click_link "Delete"
      end
      expect(current_path).to eq("/pets")
      expect(page).to_not have_content(@alfred.name)

      visit '/pets'

      within "#pet-#{@botox.id}" do
        click_link "Delete"
      end
      expect(current_path).to eq("/pets")
      expect(page).to_not have_content(@botox.name)
    end

    it "I see adoptable pets listed before pets whose adoption status is pending" do
      expect(page.find_all('.pets')[0]).to have_content("#{@henri.name}")
      expect(page.find_all('.pets')[1]).to have_content("#{@alfred.name}")
      expect(page.find_all('.pets')[2]).to have_content("#{@winston.name}")
      expect(page.find_all('.pets')[3]).to have_content("#{@botox.name}")
      expect(page.find_all('.pets')[4]).to have_content("#{@pumbaa.name}")
    end
  end
end
