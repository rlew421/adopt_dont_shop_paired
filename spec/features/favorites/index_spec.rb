require 'rails_helper'

RSpec.describe "favorites index page" do
  before :each do
    @shelter_1 = Shelter.create!(name: "Denver Dog Shelter", address: "7893 Colfax", city: "Denver", state: "CO", zip: 80209)
    @pet_1 = @shelter_1.pets.create!(image: "https://i.pinimg.com/564x/59/71/31/5971314eb28926a1ccc298396f099189.jpg",
      name: 'Pet 1',
      description: "Pet 1 description",
      approximate_age: 7,
      sex: 'Male')
    @pet_2 = @shelter_1.pets.create!(image: "https://thumbs-prod.si-cdn.com/wLrciMDDerMdsUZS8GZwduuMvPs=/420x240/filters:focal(274x157:275x158)/https://public-media.si-cdn.com/filer/ca/15/ca15e676-bfa1-4180-ae4b-02797b55c093/gettyimages-511711532_720.jpg",
      name: 'Pet 2',
      description: "Pet 2 description",
      approximate_age: 2,
      sex: 'Female')
    @pet_3 = @shelter_1.pets.create!(image: "https://vetstreet.brightspotcdn.com/dims4/default/3407f3b/2147483647/thumbnail/645x380/quality/90/?url=https%3A%2F%2Fvetstreet-brightspot.s3.amazonaws.com%2Ffb%2F31%2F032a6aae436a9821acda211044fb%2Fbulldog-ap-rn4myi-645.jpg",
      name: 'Pet 3',
      description: "Pet 2 description",
      approximate_age: 4,
      sex: 'Male')
  end
  it "I see all pets I've favorited along with:
  - a pet's name (links to pets show page)
  - a pet's image" do


    visit "/pets/#{@pet_1.id}"
    click_button "Add #{@pet_1.name} to Favorites"
    visit '/favorites'
    within "#favorited_pet-#{@pet_1.id}" do
      click_link "#{@pet_1.name}"
    end
    expect(current_path).to eq("/pets/#{@pet_1.id}")

    visit "/pets/#{@pet_2.id}"
    click_button "Add #{@pet_2.name} to Favorites"
    visit '/favorites'
    within "#favorited_pet-#{@pet_2.id}" do
      click_link "#{@pet_2.name}"
    end
    expect(current_path).to eq("/pets/#{@pet_2.id}")

    visit '/favorites'

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_css("img[src*='#{@pet_1.image}']")
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_css("img[src*='#{@pet_2.image}']")
    expect(page).to_not have_content(@pet_3.name)
    expect(page).to_not have_css("img[src*='#{@pet_3.image}']")
  end

  it "I can click a link next to each favorited pet to delete that pet from favorites" do
    visit '/favorites'

    within 'nav' do
      expect(page).to have_content("Favorites: 0")
    end

    visit "/pets/#{@pet_1.id}"
    click_button "Add #{@pet_1.name} to Favorites"

    within 'nav' do
      expect(page).to have_content("Favorites: 1")
    end

    visit "/pets/#{@pet_2.id}"
    click_button "Add #{@pet_2.name} to Favorites"

    within 'nav' do
      expect(page).to have_content("Favorites: 2")
    end

    visit '/favorites'
    within "#favorited_pet-#{@pet_1.id}" do
      click_button "Remove #{@pet_1.name} from Favorites"
    end
    expect(current_path).to eq('/favorites')

    expect(page).to_not have_css("img[src*='#{@pet_1.image}']")

    within 'nav' do
      expect(page).to have_content("Favorites: 1")
    end

    visit '/favorites'
    within "#favorited_pet-#{@pet_2.id}" do
      click_button "Remove #{@pet_2.name} from Favorites"
    end
    expect(current_path).to eq('/favorites')
    expect(page).to_not have_css("img[src*='#{@pet_2.image}']")

    within 'nav' do
      expect(page).to have_content("Favorites: 0")
    end
  end

  it "I see text saying that I have no favorited pets if I have not added any pets to my favorites list" do
    visit '/favorites'

    expect(page).to have_content("You have no favorited pets.")
  end

  it "I see a link to remove all favorited pets that empties my list of favorited pets" do
    visit "/pets/#{@pet_1.id}"
    click_button "Add #{@pet_1.name} to Favorites"
    within 'nav' do
      expect(page).to have_content("Favorites: 1")
    end

    visit "/pets/#{@pet_2.id}"
    click_button "Add #{@pet_2.name} to Favorites"
    within 'nav' do
      expect(page).to have_content("Favorites: 2")
    end

    visit '/favorites'

    click_link "Remove All Favorited Pets"
    expect(current_path).to eq('/favorites')
    expect(page).to_not have_content("#{@pet_1.name}")
    expect(page).to_not have_content("#{@pet_2.name}")
    expect(page).to have_content("You have no favorited pets.")
    within 'nav' do
      expect(page).to have_content("Favorites: 0")
    end
  end

  it "When I visit the favorites index page I see a section that has a list of all the pets that have an application on them" do
    visit "/pets/#{@pet_1.id}"
    click_button "Add #{@pet_1.name} to Favorites"

    visit "/pets/#{@pet_2.id}"
    click_button "Add #{@pet_2.name} to Favorites"

    visit "/pets/#{@pet_3.id}"
    click_button "Add #{@pet_3.name} to Favorites"

    visit '/favorites'
    click_link "Apply to Adopt Pets"

    within "#favorite-#{@pet_1.id}" do
      check("favorites[]")
    end

    within "#favorite-#{@pet_2.id}" do
      check("favorites[]")
    end

    fill_in :name, with: "John Doe"
    fill_in :address, with: "1703 11th Ave"
    fill_in :city, with: "Boulder"
    fill_in :state, with: "CO"
    fill_in :zip, with: 80423
    fill_in :phone_number, with: 7209305236
    fill_in :description, with: "I'm just searching for a new best friend"

    click_button "Submit Application"

    expect(current_path).to eq('/favorites')

    within "#applied_pets-#{@pet_1.id}" do
      click_link "#{@pet_1.name}"
    end
    expect(current_path).to eq("/pets/#{@pet_1.id}")

    visit '/favorites'

    within "#applied_pets-#{@pet_2.id}" do
      click_link "#{@pet_2.name}"
    end
    expect(current_path).to eq("/pets/#{@pet_2.id}")
  end
end
