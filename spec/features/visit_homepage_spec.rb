require 'rails_helper'

RSpec.describe "The first look at site", :type => :feature do
	it "shows signup and signin link if user is not logged" do
		visit "/"
		expect(page).to have_text("Login")
		expect(page).to have_text("Registrati")
	end
end
