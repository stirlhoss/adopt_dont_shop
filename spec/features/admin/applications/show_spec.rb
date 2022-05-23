require 'rails_helper'

RSpec.describe "admin application show page" do
  before :each do
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @application_1 = Application.create!(name: 'Mike', address: '1234 Street St', city: 'Denver', state: 'CO',
                                        zipcode: '69420', description: 'I care about pets', status: 'Pending')
    @pet_application_1 = PetApplication.create!(application: @application_1, pet: @pet_3)
  end
  
  it "can approve pets on applications" do
    visit "/admin/applications/#{@application_1.id}"
    expect(page).to have_button("Approve this Pet")
    click_on "Approve this Pet"
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")
    expect(page).to_not have_button("Approve this Pet")
    expect(page).to have_content("Approved")
  end
end
