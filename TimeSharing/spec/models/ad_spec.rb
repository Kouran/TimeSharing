require 'rails_helper'

RSpec.describe Ad, :type=> :model do
	context "when created" do
		it "is valid with valid attributes" do
			ad=Ad.new(:title => "Titolo", :category => "Categoria", :description => "Descrizione", :zone => 			"Zona", :expected_hours => 3, :deadline => Date.current, :request => false, :applicant_user => "tizio")
			expect(ad).to be_valid
		end
		it "is not valid without a title" do
			ad=Ad.new(:category => "Categoria", :description => "Descrizione", :zone => "Zona", :expected_hours => 				3, :deadline => Date.current, :request => false, :applicant_user => "tizio")
			expect(ad).to_not be_valid
		end
		it "is not valid without a category" do
			ad=Ad.new(:title => "Titolo", :description => "Descrizione", :zone => "Zona", :expected_hours => 3, :deadline 				=> Date.current, :request => false, :applicant_user => "tizio")
			expect(ad).to_not be_valid
		end
		it "is not valid without a description" do
			ad=Ad.new(:title => "Titolo", :category => "Categoria", :zone => "Zona", :expected_hours => 3, :deadline => 			Date.current, :request => false, :applicant_user => "tizio")
			expect(ad).to_not be_valid
		end
		it "is not valid without a zone" do
			ad=Ad.new(:title => "Titolo", :category => "Categoria", :description => "Descrizione", :expected_hours => 				3, :deadline => Date.current, :request => false, :applicant_user => "tizio")
			expect(ad).to_not be_valid
		end
		it "is not valid without expected hours" do
			ad=Ad.new(:title => "Titolo", :category => "Categoria", :description => "Descrizione", :zone => 			"Zona", :deadline => Date.current, :request => false, :applicant_user => "tizio")
			expect(ad).to_not be_valid
		end
		it "is not valid without a deadline" do
			ad=Ad.new(:title => "Titolo", :category => "Categoria", :description => "Descrizione", :zone => 			"Zona", :expected_hours => 3, :request => false, :applicant_user => "tizio")
			expect(ad).to_not be_valid
		end
		it "is not valid without an applicant" do
			ad=Ad.new(:title => "Titolo", :category => "Categoria", :description => "Descrizione", :zone => 			"Zona", :expected_hours => 3, :deadline => Date.current, :request => false)
			expect(ad).to_not be_valid
		end
		it "is not valid without a positive amount of expected hours" do
			ad=Ad.new(:title => "Titolo", :category => "Categoria", :description => "Descrizione", :zone => 			"Zona", :expected_hours => -3, :deadline => Date.current, :request => false, :applicant_user => "tizio")
			expect(ad).to_not be_valid
		end
	end
end
