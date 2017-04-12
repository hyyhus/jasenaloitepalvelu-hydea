require 'rails_helper'
require 'spec_helper'

RSpec.feature "Banned", type: :feature do
    let!(:user) { FactoryGirl.create(:user_banned) }
    let!(:ideaone) { FactoryGirl.create(:idea_approved) }
    let!(:user_admin){ FactoryGirl.create(:user_admin) }

    describe 'user' do
      before :each do
        page.set_rack_session(user_id: user.id)
        page.visit ideas_path
      end

      it "can not add comments"

      it "can not like ideas" do
  			click_on('0')
  			expect(page).not_to have_selector(:link_or_button, '1')
      end

      it "can not add ideas"
    end

    context 'checkbox on' do
      describe 'banned user' do
        before :each do
          page.set_rack_session(user_id: user_admin.id)
          page.visit edit_user_path(user)
        end
        it 'is checked' do
          expect(find('input[name="user[banned]"]')).to be_checked
        end
        it 'is unchecked if user is updated' do
          expect(find('input[name="user[banned]"]')).to be_checked
          find('input[name="user[banned]"]').set(false)
          click_button('Update User')
          page.visit edit_user_path(user)
          expect(find('input[name="user[banned]"]')).not_to be_checked
        end
      end

      describe 'not banned user' do
        before :each do
          page.set_rack_session(user_id: user_admin.id)
          normal_user = FactoryGirl.create(:user)
          page.visit edit_user_path(normal_user)
        end
        it 'is unchecked' do
          expect(find('input[name="user[banned]"]')).not_to be_checked
        end
        it 'is checked if user is updated' do
          expect(find('input[name="user[banned]"]')).not_to be_checked
          find('input[name="user[banned]"]').set(true)
          click_button('Update User')
          page.visit edit_user_path(user)
          expect(find('input[name="user[banned]"]')).to be_checked
        end
      end
    end
end
