require 'rails_helper'

RSpec.describe 'Admin::Shelters::Index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
  end

  describe 'index order' do
    it 'orders shelters by name descending by default' do
      visit '/admin/shelters'

      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
      expect(page).to have_content('Fancy pets of Colorado', count: 1)
    end

    it 'shows shelters with pending applications' do
      application_1 = Application.create!(name: 'Mike', address: '1234 Street St', city: 'Denver', state: 'CO',
                                          zipcode: '69420', description: 'I care about pets', status: 'Pending')
      application_2 = Application.create!(name: 'James', address: '12 Street St', city: 'Denver', state: 'CO',
                                          zipcode: '69420', description: 'I care about pets', status: 'In Progress')
      pet_application_1 = PetApplication.create!(application: application_1, pet: @pet_3)
      pet_application_2 = PetApplication.create!(application: application_2, pet: @pet_1)

      visit '/admin/shelters'

      expect(page).to have_content('Shelters with Pending Applications:')
      expect(page).to have_content('Fancy pets of Colorado', count: 2)
    end

    it "shows pending shelters in alphabetical ascending order" do
      application_1 = Application.create!(name: 'Mike', address: '1234 Street St', city: 'Denver', state: 'CO',
                                          zipcode: '69420', description: 'I care about pets', status: 'Pending')
      application_2 = Application.create!(name: 'James', address: '12 Street St', city: 'Denver', state: 'CO',
                                          zipcode: '69420', description: 'I care about pets', status: 'Pending')
      pet_application_1 = PetApplication.create!(application: application_1, pet: @pet_3)
      pet_application_2 = PetApplication.create!(application: application_2, pet: @pet_1)
      visit '/admin/shelters'
      within '#pending' do
        expect(@shelter_1.name).to appear_before(@shelter_3.name)
      end
    end
  end
end
