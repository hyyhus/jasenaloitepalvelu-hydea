require 'rails_helper'
require 'spec_helper'

RSpec.feature "Show idea", type: :feature do

	describe "With no user logged in" do
		describe "With a new idea" do
			let(:idea_new){ FactoryGirl.create(:idea_new) }

			it "does not have draw like button" do
				page.visit idea_path(idea_new)
				expect(page).not_to have_selector(:link_or_button, '0')
			end
		end
		describe "With an approved idea" do
			let(:idea_approved){ FactoryGirl.create(:idea_approved) }

			before :each do
				page.visit idea_path(idea_approved)
			end
			it "draws a like button with no likes" do
				expect(page).not_to have_selector(:link_or_button, '1')
				expect(page).to have_selector(:link_or_button, '0')
			end
			it "does not add a like when clicked" do
				expect(page).not_to have_selector(:link_or_button, '1')
				click_on('0')
				expect(page).not_to have_selector(:link_or_button, '1')
			end
		end
	end
	describe "With user logged in" do
		let!(:user){ FactoryGirl.create(:user) }
		before :each do
			page.set_rack_session(:user_id => user.id)
		end

		describe "With a new idea" do
			let(:idea){ FactoryGirl.create(:idea) }

			it "does not draw a like button" do
				page.visit idea_path(idea)
				expect(page).not_to have_selector(:link_or_button, '0')
			end
		end
		describe "With an approved idea" do
			let(:idea_approved){ FactoryGirl.create(:idea_approved) }

			before :each do
				page.visit idea_path(idea_approved)
			end
			it "draws a like button with no likes" do
				expect(page).not_to have_selector(:link_or_button, '1')
				expect(page).to have_selector(:link_or_button, '0')
			end
			it "adds a like when clicked" do
				expect(page).not_to have_selector(:link_or_button, '1')
				click_on('0')
				expect(page).to have_selector(:link_or_button, '1')
			end
		end
	end
end
