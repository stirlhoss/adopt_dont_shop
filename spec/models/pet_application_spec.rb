require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  before :each do
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @application_1 = Application.create!(name: 'Mike', address: '1234 Street St', city: 'Denver', state: 'CO',
                                        zipcode: '69420', description: 'I care about pets', status: 'Pending')
    @pet_application_1 = PetApplication.create!(application: @application_1, pet: @pet_3)
  end

  it "find pet_application for specific pet and application combination" do
    binding.pry
    expect(PetApplication.pet_app_find(@application_1.id, @pet_3.id)).to eq(@pet_application_1)
  end
end
