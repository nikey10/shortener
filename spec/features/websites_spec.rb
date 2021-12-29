require 'rails_helper'

RSpec.feature "Websites", type: :feature do
  before(:each) do
    visit root_path
  end

  context "Add new website" do
    scenario "should be successful" do
      fill_in "Website URL", with: "https://example.com"
      click_button "Add website"
      expect(page).to have_content("Your link")
    end

    scenario "empty url string provided" do
      click_button "Add website"
      expect(page).to have_content("Url can't be blank")
    end

    scenario "url invalid format" do
      fill_in "Website URL", with: "example.com"
      click_button "Add website"
      expect(page).to have_content("Url is invalid")
    end
  end
end
