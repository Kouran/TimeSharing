FactoryGirl.define do
	factory :personaldatum, class: PersonalDatum do
		association :user, factory: :user, strategy: :build
	end
end
