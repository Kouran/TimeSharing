FactoryGirl.define do
	factory :ad do
		title "Titolo"
		category "Categoria"
		description "Descrizione"
		expected_hours 3
		deadline Date.new(2017,2,20)
		applicant_user "tizio"
	end
end
