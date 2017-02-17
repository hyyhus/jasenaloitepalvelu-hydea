FactoryGirl.define do
	factory :user do
		name "Testi Tauno"
		email "testi@blaa.fi"
		admin "false"
		moderator "false"
		title "opiskelija"
		persistent_id "9876543"
	end

	# factory :haka_user, class: User do
	# 	name	
	# end


end



