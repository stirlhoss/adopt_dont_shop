require 'rails_helper'

 RSpec.describe "Applications Show Page" do
   before :each do
     @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
     @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
     @application_1 = Application.create!(name: "Mike", address: "1234 Street St", city: 'Denver', state: 'CO', zipcode: '69420', description: "I care about pets", status: "Pending")
   end

   it "visit show page and shows application attributes" do
     visit "/applications/#{@application_1.id}"
     expect(page).to have_content("Mike")
     expect(page).to have_content("1234 Street St")
     expect(page).to have_content("Denver")
     expect(page).to have_content("CO")
     expect(page).to have_content("69420")
     expect(page).to have_content("I care about pets")
     expect(page).to have_content("Pending")
     expect(page).to have_content("Pets Applied For:")
   end

   it "can search available pets in application show page" do
     @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
     @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
     @application_1 = Application.create!(name: "Mike", address: "1234 Street St", city: 'Denver', state: 'CO', zipcode: '69420', description: "No Description", status: "Pending")
     visit "/applications/#{@application_1.id}"
     expect(page).to have_button("Submit")
     expect(page).to have_content("Add a Pet to this Application")
     fill_in :search, with: "Mr. Pirate"
     click_on("Submit")
     expect(current_path).to eq("/applications/#{@application_1.id}")
     expect(page).to have_content(@pet_1.name)
    end

    it "can add pet to application" do
      visit "/applications/#{@application_1.id}"
      fill_in :search, with: "Mr. Pirate"
      click_on("Submit")
      click_link("Adopt this Pet")
      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content("Pets Applied For: Mr. Pirate")
    end
 end
