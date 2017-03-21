require 'rails_helper'
require 'spec_helper'

RSpec.feature "Likes", type: :feature do
	describe "With a single like" do
		let!(:user_moderator){ FactoryGirl.create(:user_moderator) }
		let!(:idea_approved){ FactoryGirl.create(:idea_approved) }
		let!(:user){ FactoryGirl.create(:user) }


		before :each do
			page.set_rack_session(:user_id => user_moderator.id)
			page.visit '/ideas?basket=Approved'
		end

		it "should not be liked at first" do
			expect(page).to have_selector(:link_or_button, '0')
		end

		it "should be liked after clicking" do
			click_on('0')
			expect(page).to have_selector(:link_or_button, '1')
		end
		it "should be unliked after clicking again" do
			click_on('0')
			expect(page).to have_selector(:link_or_button, '1')
			click_on('1')
			expect(page).to have_selector(:link_or_button, '0')
		end
	end
end
