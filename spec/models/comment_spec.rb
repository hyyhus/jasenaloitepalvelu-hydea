require 'rails_helper'

RSpec.describe Comment, type: :model do

	describe "user and idea exist" do
		let(:user){FactoryGirl.create(:user, name: "Testi Tauno")}
		let(:comment){FactoryGirl.create(:comment, user: user, text: "comment text")}

		it "has factory make comment with all" do
			expect(comment.user.name).to eq("Testi Tauno")
			expect(comment.time).not_to be_nil
			expect(comment.text).to eq("comment text")
		end


	end
	describe "with valid attributes" do
		let(:comment){FactoryGirl.build(:comment)}

		it "is valid" do
			expect(comment).to be_valid
		end
	end
	describe "with no text set" do
		let(:comment){FactoryGirl.build(:comment, text: nil)}
		it "is not valid" do
			expect(comment).not_to be_valid
		end
	end
	describe "with no time set" do
		let(:comment){FactoryGirl.build(:comment, time: nil)}
		it "is not valid" do
			expect(comment).not_to be_valid
		end
	end
	describe "with no idea set" do
		let(:comment){FactoryGirl.build(:comment, idea: nil)}
		it "is not valid" do
			expect(comment).not_to be_valid
		end
	end
	describe "with no user set" do
		let(:comment){FactoryGirl.build(:comment, user: nil)}
		it "is not valid" do
			expect(comment).not_to be_valid
		end
	end
	describe "with no visibility set" do
		let(:comment){FactoryGirl.build(:comment, visible: nil)}
		it "is not valid" do
			expect(comment).not_to be_valid
		end
	end
	describe "with invalid idea" do
		let(:idea){FactoryGirl.build(:idea, topic: nil)}
		let(:comment){FactoryGirl.build(:comment, idea: idea)}
		it "is not valid" do
			expect(comment).not_to be_valid
		end
	end
	describe "with invalid user" do
		let(:user){FactoryGirl.build(:user, persistent_id: nil)}
		let(:comment){FactoryGirl.build(:comment, user: user)}
		it "is not valid" do
			expect(comment).not_to be_valid
		end
	end
end
