FactoryGirl.define do
	factory :transaction do
		amount 1
		association :from, factory: :user, strategy: :build
		association :to, factory: :user2, strategy: :build
		association :ad, factory: :ad, strategy: :build
	end
end
