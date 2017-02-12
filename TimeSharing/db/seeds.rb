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
Ad.create(title: "Titolo1", category: "Categoria di prova", description: "Lorem ipsum banana droga", expected_hours: 1, deadline: Date.new(2017,2,20), applicant_user: "tizio")
Ad.create(title: "Titolo2", category: "Categoria di prova", description: "Viva telegram", expected_hours: 1, deadline: Date.new(2017,2,20), applicant_user: "tizio")
Ad.create(title: "Titolo3", category: "Categoria di prova", description: "Banana terracotta terracotta pie", expected_hours: 1, deadline: Date.new(2017,2,20), applicant_user: "tizio")
Ad.create(title: "Titolo4", category: "Categoria di prova", description: "Daje col 18", expected_hours: 1, deadline: Date.new(2017,2,20), applicant_user: "tizio")
Ad.create(title: "Titolo5", category: "Categoria di prova", description: "SEGRETO", expected_hours: 1, deadline: Date.new(2017,2,20), applicant_user: "tizio")
