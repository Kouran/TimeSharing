FactoryGirl.define do
	factory :ad do
		title "Titolo"
		category "Categoria"
		description "Descrizione"
		zone "Zona"
		expected_hours 3
		deadline Date.new(2017,2,20)
		request false
		applicant_user "tizio"
	end
end
