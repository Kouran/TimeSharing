FactoryGirl.define do
	factory :message do
		sender "Sender"
		receiver "Receiver"
		title "Title"
		body "Body"
	end
end
