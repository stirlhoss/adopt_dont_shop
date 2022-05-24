require 'rails_helper'

RSpec.describe "Admin Application Show Page" do
  it "shows shelters name and full address" do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    visit "/admin/shelters/#{shelter_1.id}"
    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_1.city)
  end
end
