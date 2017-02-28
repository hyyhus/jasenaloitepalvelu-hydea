FactoryGirl.define do
	
	factory :user do
		name "Testi Tauno"
		email "testi@blaa.fi"
		admin "false"
		moderator "false"
		title "opiskelija"
		persistent_id "9876543"
	end

	factory :user_with_history, class: User do
		name "Testi Testaaja"
		email "testaaja@blaa.fi"
		admin "false"
		moderator "false"
		title "opiskelija"
		persistent_id "9876543111"
		
	end

	factory :comment do
  		time Time.now
  		text "comment text"
  		idea_id 1
  		user_id 1

		#idea_id {FactoryGirl.create(:idea)}
	   	#user_id {FactoryGirl.create(:user)}

  	end

	factory :history do
		time Time.now
		basket "New"
		idea_id 1
  		user_id 1
  	end


#ideas and tags belongs_and_has_many to be done

	factory :idea do
		topic "idea topic"
		text "idea text"		
		histories {[FactoryGirl.create(:history)]}
		tags {[FactoryGirl.create(:tag)]}
	end

	factory :tag do
		text "tag text"

		#factory :tag_has_many_ideas do
		#	after(:create) do |tag|
		#		ideas {[FactoryGirl.create(:idea)]}
		#	end
		#end
	end

	factory :like do
		like_type "like"
		user_id 1
		idea {FactoryGirl.create(:idea)}

		#user {FactoryGirl.create(:user)}
		#idea {FactoryGirl.create(:idea)}
	end

end

# USECASE
# user = user(:user_with_all)
# 
# OR
#
# article = create(:article)
# create(:comment, article: article)


