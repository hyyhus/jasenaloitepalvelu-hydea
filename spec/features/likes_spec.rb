require 'rails_helper'
require 'spec_helper'

RSpec.feature "Likes", type: :feature do
	let!(:user_moderator){ FactoryGirl.create(:user_moderator) }
	let!(:idea_approved){ FactoryGirl.create(:idea_approved) }
	let!(:user){ FactoryGirl.create(:user) }

	describe "With a single like" do
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

	context 'are drawn' do
  	describe 'clickable' do
			before :each do
				page.set_rack_session(:user_id => user_moderator.id)
				page.visit '/ideas?basket=Approved'
			end

	    it 'if basket is Approved' do
				all('a.btn.btn-default').last.find('.glyphicon.glyphicon-thumbs-up')
	    end
		end

		describe 'disabled' do
			before :each do
				page.set_rack_session(:user_id => user_moderator.id)
				page.visit '/ideas?basket=Approved'
			end

			it 'if basket is Changing' do
				click_link('Muutettava')
				visit '/ideas?basket=Changing'
				find('button.btn.btn-default.disabled')
			end

			it 'if basket is Changed' do
				click_link('Muutettu')
				visit '/ideas?basket=Changed'
				find('button.btn.btn-default.disabled')
			end

			it 'if basket is Not Changed' do
				click_link('Ei muutettu')
				visit '/ideas?basket=Not+Changed'
				find('button.btn.btn-default.disabled')
			end
		end
	end
end
