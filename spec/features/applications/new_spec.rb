require 'rails_helper'

RSpec.describe "Applications New Page" do
 describe "can fill out a new application" do
   it "can link to application new page" do
     visit '/pets'
     click_on 'Start an Application'
     expect(current_path).to eq('/applications/new')
   end

    it "can fill out a new application form" do
      visit '/applications/new'

      fill_in("name", with: "Stirling")
      fill_in("address", with: "1234 Test Road")
      fill_in("city", with: "Peoria")
      fill_in("state", with: "IL")
      fill_in("zipcode", with: "61606")
      fill_in("description", with: "I love pets")

      click_on "Submit"

      expect(current_path).to eq("/applications/#{Application.first.id}")

      expect(page).to have_content("Stirling")
      expect(page).to have_content("1234 Test Road")
      expect(page).to have_content("Peoria")
      expect(page).to have_content("IL")
      expect(page).to have_content("61606")
      expect(page).to have_content("I love pets")
    end
  end
end
