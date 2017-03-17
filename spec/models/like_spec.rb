require 'rails_helper'

RSpec.describe Like, type: :model do
	let(:idea){ FactoryGirl.create(:idea, id: 1)}
	let(:user){FactoryGirl.create(:user, id: 1)}
	let(:like){FactoryGirl.create(:like, idea: idea, user: user)}
	it "has factory make like with all" do
		like = FactoryGirl.create(:like)
	end
	it "is valid with single like" do
		byebug
		expect(like).to be_valid
	end
	it "is valid with multiple likes" do
		liketwo = FactoryGirl.create(:like, idea: idea)
		expect(liketwo).to be_valid
	end
	it "is not valid with duplicate likes" do
		expect(like).to be_valid
		liketwo= FactoryGirl.build(:like, user: user, idea: idea)
		expect(liketwo).not_to be_valid
	end
end
