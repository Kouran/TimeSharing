# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
plat=UserPlatformDatum.create(:access => 1, :wallet => 999)
User.create(:email => "email@email.com", :nickname => "user", :password => "a", :password_confirmation => "a", :plat => plat)
platmod=UserPlatformDatum.create(:access => 2, :wallet => 999)
User.create(:email => "mod@email.com", :nickname => "mod", :password => "a", :password_confirmation => "a", :plat => platmod)
platadmin=UserPlatformDatum.create(:access => 3, :wallet => 999)
User.create(:email => "admin@email.com", :nickname => "admin", :password => "a", :password_confirmation => "a", :plat => platadmin)
