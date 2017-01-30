FactoryGirl.define do
	factory :user_data, class: UserPlatformDatum do
		wallet 2
		access 1	
	end
	factory :mod_data, class: UserPlatformDatum do
		wallet 2
		access 2
	end
	factory :admin_data, class: UserPlatformDatum do
		wallet 2
		access 3
	end
end
