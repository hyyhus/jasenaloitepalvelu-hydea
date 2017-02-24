# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# #Demo test data
# u1 = User.create name:"Onni Opiskelija", email:"onni.opiskelija@helsinki.fi", title:"opiskelija", persistent_id:"83030478869631327488", admin:false, moderator:false
# u2 = User.create name:"Anni Admin", email:"anni.admin@helsinki.fi", title:"admin", persistent_id:"83030478869631327588", admin:true, moderator:false
# u3 = User.create name:"Mauri Moderaattori", email:"mauri.moderaattori@helsinki.fi", title:"moderaattori", persistent_id:"83030478869631327688", admin:false, moderator:true

# i1 = Idea.create topic:"Virtuaalilasit laitokselle", text:"Software Factoryssa tarvitaan VR-laseja"
# h1= History.create time: "2017-02-06 13:39:46", basket_id:1, user_id:1, idea_id:1

# c1 = Comment.create user_id:1, time: "2017-02-06 15:10:00", text:"Eka", idea_id:1
# c2 = Comment.create user_id:2, time: "2017-02-06 15:13:00", text:"Kannatetaan", idea_id:1
# c3 = Comment.create user_id:3, time: "2017-02-06 15:15:00", text:"Huikea idea", idea_id:1

# #/Demo test data


#baskets = ["New", "Approved", "Rejected", "Changing", "Changed", "Not changed"]
#baskets.each {|b| Basket.create!(name: b)}



case Rails.env
when "development", "test", "production"

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
		topic = Faker::ChuckNorris.fact
		text = Faker::Lorem.paragraph(5, false, 15)		
		Idea.create!(topic: topic, text: text)
		History.create!(time: Faker::Date.backward(265), basket: "New", user_id: (Random.rand(admins+moderators+users)+1), idea_id: (n+1) )

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
