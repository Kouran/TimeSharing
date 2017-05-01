FactoryGirl.define do
	factory :user do
		email "email@email.com"
		password "password"
		password_confirmation "password"
		nickname "nickname"
		association :plat, factory: :user_data
	end

	factory :user2, class: User do
		email "else@email.com"
		password "password"
		password_confirmation "password"
		nickname "else"
		association :plat, factory: :user_data
	end

	factory :mod, class: User do
		email "mod@email.com"
		password "password"
		password_confirmation "password"
		nickname "mod"
		association :plat, factory: :mod_data
	end

	factory :admin, class: User do
		email "admin@email.com"
		password "password"
		password_confirmation "password"
		nickname "admin"
		association :plat, factory: :admin_data
	end
end
