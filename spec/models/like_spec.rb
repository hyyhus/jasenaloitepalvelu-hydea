require 'rails_helper'

RSpec.describe Like, type: :model do
	it "has factory make like with all" do
	idea = FactoryGirl.create(:idea)
	user = FactoryGirl.create(:user)
	like = FactoryGirl.create(:like, idea: idea, user: user)
		like = FactoryGirl.create(:like)
	end
	it "is valid with single like" do
	idea = FactoryGirl.create(:idea)
	user = FactoryGirl.create(:user)
	like = FactoryGirl.create(:like, idea: idea, user: user)
		like = FactoryGirl.create(:like)
		expect(like).to be_valid
	end
	it "is valid with multiple likes" do
	idea = FactoryGirl.create(:idea)
	user = FactoryGirl.create(:user)
	like = FactoryGirl.create(:like, idea: idea, user: user)
		liketwo = FactoryGirl.create(:like, idea: idea)
		expect(liketwo).to be_valid
	end
	it "is not valid with duplicate likes" do
	idea = FactoryGirl.create(:idea)
	user = FactoryGirl.create(:user)
	like = FactoryGirl.create(:like, idea: idea, user: user)
		expect(like).to be_valid
		liketwo= FactoryGirl.build(:like, user: user, idea: idea)
		expect(liketwo).not_to be_valid
	end
end
