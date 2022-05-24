require 'rails_helper'

RSpec.describe "admin application show page" do
  before :each do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @application_1 = Application.create!(name: 'Mike', address: '1234 Street St', city: 'Denver', state: 'CO',
                                        zipcode: '69420', description: 'I care about pets', status: 'Pending')
    @application_2 = Application.create!(name: 'James', address: '2358 Drive St', city: 'Denver', state: 'CO',
                                        zipcode: '69420', description: 'I care about pets', status: 'Pending')
    @pet_application_1 = PetApplication.create!(application: @application_1, pet: @pet_3)
    @pet_application_2 = PetApplication.create!(application: @application_2, pet: @pet_3)
  end
  
  it "can approve pets on applications" do
    visit "/admin/applications/#{@application_1.id}"
    expect(page).to have_button("Approve this Pet")
    click_on "Approve this Pet"
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")
    expect(page).to_not have_button("Approve this Pet")
    expect(page).to have_content("Approved")
  end

  it "can reject pets on applications" do
    visit "/admin/applications/#{@application_1.id}"
    expect(page).to have_button("Reject this Pet")
    click_on "Reject this Pet"
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")
    expect(page).to_not have_button("Reject this Pet")
    expect(page).to have_content("Rejected")
  end

  it 'can approve/reject the same pet on multiple applications' do
    visit "/admin/applications/#{@application_1.id}"
    expect(page).to have_button("Approve this Pet")
    click_on "Approve this Pet"
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")
    expect(page).to_not have_button("Approve this Pet")
    expect(page).to have_content("Approved")

    visit "/admin/applications/#{@application_2.id}"
    expect(page).to have_button("Approve this Pet")
    click_on "Approve this Pet"
    expect(current_path).to eq("/admin/applications/#{@application_2.id}")
    expect(page).to_not have_button("Approve this Pet")
    expect(page).to have_content("Approved")
  end

  it 'once all pets on page have been accepted, application is approved' do
    @application_1.pets << @pet_1
    visit "/admin/applications/#{@application_1.id}"
    click_on ("Approve this Pet"), match: :first
    click_on "Approve this Pet"
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")
    expect(page).to have_content("Application Status: Approved")
  end

  it 'once all pets on page have been accepted/rejected, application is rejected' do
    @application_1.pets << @pet_1
    visit "/admin/applications/#{@application_1.id}"
    click_on ("Approve this Pet"), match: :first
    click_on "Reject this Pet"
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")
    expect(page).to have_content("Application Status: Rejected")
  end
end
