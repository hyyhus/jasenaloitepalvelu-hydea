require 'rails_helper'
require 'spec_helper'

RSpec.feature 'Comments', type: :feature do
  describe 'That are visible' do
    let!(:user_moderator) { FactoryGirl.create(:user_moderator) }
    let!(:user) { FactoryGirl.create(:user) }
    let!(:comment) { FactoryGirl.create(:comment, text: 'comment to be removed', idea: (FactoryGirl.create(:idea_approved))) }

    context 'With moderator signed in' do
      before :each do
        page.set_rack_session(user_id: user_moderator.id)
        page.visit idea_path(comment.idea)
      end

      it 'should have comment' do
        expect(page).to have_content('comment to be removed')
      end

      it 'should have Delete button' do
        expect(page).to have_selector(:link_or_button, 'Delete')
      end

      it 'should be deleted after clicking' do
        click_on('Delete')
        expect(page).not_to have_content('comment to be removed')
      end

      it 'should have unpublish button' do
        expect(page).to have_selector(:link_or_button, 'Unpublish')
      end

      it 'should not have publish button' do
        expect(page).not_to have_selector(:link_or_button, 'Publish')
      end

      it 'should have publish button after clicking' 
       # expect(page).to have_selector(:link_or_button, 'Unpublish')
       # click_on('Unpublish')
       # expect(page).to have_selector(:link_or_button, 'Publish')
      
    end

    context 'With non-moderator signed in' do
      before :each do
        page.set_rack_session(user_id: user.id)
        page.visit idea_path(comment.idea)
      end

      it 'should have comment' do
        expect(page).to have_content('comment to be removed')
      end

      it 'should not have Delete button' do
        expect(page).not_to have_selector(:link_or_button, 'Delete')
      end
    end
  end

  describe 'That are not visible' do
    let!(:user_moderator) { FactoryGirl.create(:user_moderator) }
    let!(:user) { FactoryGirl.create(:user) }
    let!(:comment) { FactoryGirl.create(:comment, text: 'comment to be removed', visible: false) }

    context 'With moderator signed in' do
      before :each do
        page.set_rack_session(user_id: user_moderator.id)
        page.visit idea_path(comment.idea)
      end

      it 'should have comment' do
        expect(page).to have_content('comment to be removed')
      end

      it 'should have Delete button' do
        expect(page).to have_selector(:link_or_button, 'Delete')
      end

      it 'should be deleted after clicking' do
        click_on('Delete')
        expect(page).not_to have_content('comment to be removed')
      end
    end

    context 'With non-moderator signed in' do
      before :each do
        page.set_rack_session(user_id: user.id)
        page.visit idea_path(comment.idea)
      end

      it 'should not have comment' do
        expect(page).not_to have_content('comment to be removed')
      end

      it 'should not have Delete button' do
        expect(page).not_to have_selector(:link_or_button, 'Delete')
      end
    end
  end
end
