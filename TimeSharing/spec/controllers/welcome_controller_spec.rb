require 'rails_helper'

RSpec.describe WelcomeController, :type=> :controller do
	describe "GET home" do
		it "renders the home page" do
			get :home
			expect(response).to render_template('home')
		end
	end
	
	describe "GET contatti" do
		it "renders the contact page" do
			get :contatti
			expect(response).to render_template('contatti')
		end
	end
end
