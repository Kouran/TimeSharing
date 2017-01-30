FactoryGirl.define do
	factory :user do
		email "email@email.com"
		password "password"
		password_confirmation "password"
		nickname "nickname"
		association :plat, factory: :user_data, strategy: :build
	end

	factory :user2, class: User do
		email "else@email.com"
		password "password"
		password_confirmation "password"
		nickname "else"
		association :plat, factory: :user_data, strategy: :build
	end

	factory :mod, class: User do
		email "email@email.com"
		password "password"
		password_confirmation "password"
		nickname "nickname"
		association :plat, factory: :mod_data, strategy: :build
	end

	factory :admin, class: User do
		email "email@email.com"
		password "password"
		password_confirmation "password"
		nickname "nickname"
		association :plat, factory: :admin_data, strategy: :build
	end
end
