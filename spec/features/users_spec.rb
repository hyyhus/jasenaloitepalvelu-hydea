require 'rails_helper'
require 'spec_helper'

RSpec.describe 'UserFeature', type: :feature do
  let!(:idea){ FactoryGirl.create(:idea) }
  let!(:user){ FactoryGirl.create(:user) }
  let!(:user_student){ FactoryGirl.create(:user_student) }
  let!(:user_moderator){ FactoryGirl.create(:user_moderator) }
  let!(:user_admin){ FactoryGirl.create(:user_admin) }

  context 'User is viewed' do
    describe 'and idea has basket New' do
      it 'it is shown to creator' do
        page.set_rack_session(:user_id => 1)
        visit '/users/1'
        expect(page).to have_content('idea topic')
      end

      it 'it is not shown to other users' do
        page.set_rack_session(:user_id => user_student.id)
        visit '/users/1'
        expect(page).not_to have_content('idea topic')
      end

      it 'it is shown to moderator' do
        page.set_rack_session(:user_id => 3)
        visit '/users/1'
        expect(page).to have_content('idea topic')
      end

      it 'it is not shown to admin' do
        page.set_rack_session(:user_id => 4)
        visit '/users/1'
        expect(page).not_to have_content('idea topic')
      end
    end

    describe 'and idea has basket Approved' do
      before :each do
        idea.histories << FactoryGirl.create(:history, basket: 'Approved')
      end

      it 'it is shown to creator' do
        page.set_rack_session(:user_id => 1)
        visit '/users/1'
        expect(page).to have_content('idea topic')
      end

      it 'it is shown to other users' do
        page.set_rack_session(:user_id => 2)
        visit '/users/1'
        expect(page).to have_content('idea topic')
      end

      it 'it is shown to moderator' do
        page.set_rack_session(:user_id => 3)
        visit '/users/1'
        expect(page).to have_content('idea topic')
      end

      it 'it is shown to admin' do
        page.set_rack_session(:user_id => 4)
        visit '/users/1'
        expect(page).to have_content('idea topic')
      end
    end

    describe 'and idea has basket Rejected' do
      before :each do
        idea.histories << FactoryGirl.create(:history, basket: 'Rejected')
      end

      it 'it is shown to creator' do
        page.set_rack_session(:user_id => 1)
        visit '/users/1'
        expect(page).to have_content('idea topic')
      end

      it 'it is not shown to other users' do
        page.set_rack_session(:user_id => 2)
        visit '/users/1'
        expect(page).not_to have_content('idea topic')
      end

      it 'it is shown to moderator' do
        page.set_rack_session(:user_id => 3)
        visit '/users/1'
        expect(page).to have_content('idea topic')
      end

      it 'it is not shown to admin' do
        page.set_rack_session(:user_id => 4)
        visit '/users/1'
        expect(page).not_to have_content('idea topic')
      end
    end
  end

  context 'Admin is logged in' do
    describe 'edits user' do
      before :each do
        page.set_rack_session(user_id: user_admin.id)
      end

      it 'removing moderator' do
        page.visit edit_user_path(user_moderator)
        uncheck('user[moderator]')
        click_on('Update User')
        page.visit edit_user_path(user_moderator)
        page.check('user_moderator')
        checkbox = find_by_id('user_moderator')
        checkbox.has_no_checked_field?
      end

      it 'adding moderator' do
        page.visit edit_user_path(user)
        check('user[moderator]')
        click_on('Update User')
        page.visit edit_user_path(user)
        checkbox = find_by_id('user_moderator')
        checkbox.has_checked_field?
      end
    end
  end
end
