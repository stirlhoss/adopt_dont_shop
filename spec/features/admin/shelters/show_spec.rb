require 'rails_helper'

RSpec.describe "Admin Application Show Page" do
  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 5, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
  end
  it "shows shelters name and full address" do
    visit "/admin/shelters/#{@shelter_1.id}"
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.city)
  end

  it "gives average age of adoptable pets in a shelter" do
    visit "/admin/shelters/#{@shelter_1.id}"
    expect(page).to have_content("Average Age of Pet at this Shelter: #{@shelter_1.pets.avg_age}")
  end

  it "shows count of adoptable pets at a shelter" do
    visit "/admin/shelters/#{@shelter_1.id}"
    expect(page).to have_content("Number of Pets at this Shelter: #{@shelter_1.pets.number_of_pets}")
  end

  it "shows number of pets that have been adopted from shelter" do
    visit "/admin/shelters/#{@shelter_1.id}"
    expect(page).to have_content("Number of Pets who have been Adopted: #{@shelter_1.pets.number_of_adopted}")
  end
end
