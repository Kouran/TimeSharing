require 'rails_helper'

RSpec.describe "Viewing help page", :type => :feature do
	before(:each) do
		visit "/"
		click_link "La nostra idea"
	end
	it "shows all ads" do
		expect(page).to have_text("Per usare la maggior parte delle funzioni fornite da questo sito è necessario registrare (gratuitamente, ora e per sempre) un account.")
	end
end
