require 'rails_helper'

RSpec.describe "Viewing all ads", :type => :feature do
	before(:each) do
		@ad=create(:ad)
		@ad.title="This should be found"
		@ad.save
		visit "/"
		click_link "Tutti gli annunci"
	end
	it "shows all ads" do
		expect(page).to have_text("This should be found")
	end
end
