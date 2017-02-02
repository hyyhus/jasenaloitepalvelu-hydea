# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

baskets = ["New", "Approved", "Rejected", "Changing", "Changed", "Not changed"]
baskets.each {|b| Basket.create!(name: b)}

case Rails.env
when "development", "test"

	tags = ["Keskusta", "Viikki", "Kumpula", "Meilahti", "Unicafe", "Kulttuuri", "Edut", "Järjestöt"]
	tags.each {|t| Tag.create!(text: t)}

	admins=5
	moderators=15
	users=80
	ideas=20
	likes=50
	comments=50

	Faker::Config.locale = 'fin'


	admins.times do |n|
		firstName  = Faker::Name.first_name
		lastName = Faker::Name.last_name
		name = "#{firstName} #{lastName}"
		ename = I18n.transliterate("#{firstName}.#{lastName}")
		email = "#{ename}@helsinki.fi".downcase
		persistent_id = Faker::Number.unique.number(20)
		title = Faker::Company.profession
		User.create!(name:  name,
			     email: email,
			     admin: true,
			     moderator: false,
			     persistent_id: persistent_id,
			     title: title
			    )

	end

	moderators.times do |n|
		firstName  = Faker::Name.first_name
		lastName = Faker::Name.last_name
		name = "#{firstName} #{lastName}"
		ename = I18n.transliterate("#{firstName}.#{lastName}")
		email = "#{ename}@helsinki.fi".downcase
		persistent_id = Faker::Number.unique.number(20)
		title = Faker::Company.profession
		User.create!(name:  name,
			     email: email,
			     admin: false,
			     moderator: true,
			     persistent_id: persistent_id,
			     title: title
			    )

	end

	users.times do |n|
		firstName  = Faker::Name.first_name
		lastName = Faker::Name.last_name
		name = "#{firstName} #{lastName}"
		ename = I18n.transliterate("#{firstName}.#{lastName}")
		email = "#{ename}@helsinki.fi".downcase
		persistent_id = Faker::Number.unique.number(20)
		title = Faker::Company.profession
		User.create!(name:  name,
			     email: email,
			     admin: false,
			     moderator: false,
			     persistent_id: persistent_id,
			     title: ""
			    )
	end

	ideas.times do |n|
		topic = Faker::Lorem.sentence
		text = Faker::Lorem.paragraph(5, false, 15)
		basket_id = (Random.rand(baskets.count)+1)
		Idea.create!(topic: topic, text: text, basket_id: basket_id)
		History.create!(time: Faker::Date.backward(265), basket_id: 1, user_id: (Random.rand(admins+moderators+users)+1), idea_id: (n+1) )

	end

	#Probably causes likes and dislikes from same user on one idea too
	likes.times do |n|
		like_type = ["like","dislike"].sample
		user_id = (Random.rand(admins+moderators+users)+1)
		idea_id = (Random.rand(admins+moderators+users)+1)
		Like.create!(like_type: like_type, user_id: user_id, idea_id: idea_id)
	end

	comments.times do |n|
		user_id = (Random.rand(admins+moderators+users)+1)
		idea_id = (Random.rand(ideas)+1)
		text = Faker::Lorem.paragraph(5, false, 15)
		time = Faker::Date.backward(365)
		Comment.create!(user_id: user_id, idea_id: idea_id, text: text, time: time)
	end

	#Blindly do some tagging
	tags.size.times do |n|
		Idea.all.sample.tags << Tag.all.sample
	end

when "production"
end
