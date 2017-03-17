require 'rails_helper'

RSpec.describe "Idea comments", type: :feature do
	let!(:user){ FactoryGirl.create(:user) }
	let!(:user_moderator){ FactoryGirl.create(:user_moderator) }
	let!(:user_student){ FactoryGirl.create(:user_student) }
	let!(:idea){ FactoryGirl.create(:idea) }
	let!(:comment){ FactoryGirl.create(:comment) }
	it "should contain moderator title by poster" do
		FactoryGirl.create(:comment, text: "testi", idea: idea, user: user_moderator)
		FactoryGirl.create(:history, basket: "Approved", idea_id: idea.id, user_id: user.id)
		page.set_rack_session(:user_id => user.id)
		page.visit ideas_path
		expect(page).to have_content('työntekijä')	
	end

	it "should contain moderator title by poster" do
			FactoryGirl.create(:comment, text: "testi", idea: idea, user: user_student)
			FactoryGirl.create(:history, basket: "Approved", idea_id: idea.id, user_id: user.id)
			page.set_rack_session(:user_id => user.id)
			page.visit ideas_path
			expect(page).not_to have_content('(opiskelija)')	
		end
end
