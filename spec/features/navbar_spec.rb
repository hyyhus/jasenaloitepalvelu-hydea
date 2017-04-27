require 'rails_helper'
require 'spec_helper'

RSpec.feature "Navbar", type: :feature do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user_moderator){ FactoryGirl.create(:user_moderator) }
  let!(:user_admin){ FactoryGirl.create(:user_admin) }

  describe 'shows correct links' do
    it 'while user not logged in' do
      visit '/'
      expect(page).to have_link('Ideat')
      expect(page).to have_link('UKK')
      expect(page).not_to have_link('Tägit')
      expect(page).not_to have_link('Käyttäjät')
      expect(page).to have_link('Kirjaudu sisään')
    end

    it 'while user is logged in' do
      page.set_rack_session(user_id: user.id)
      visit '/'
      expect(page).to have_link('Ideat')
      expect(page).to have_link('UKK')
      expect(page).not_to have_link('Tägit')
      expect(page).not_to have_link('Käyttäjät')
      expect(page).to have_link('Kirjaudu ulos')
    end

    it 'while user is moderator' do
      page.set_rack_session(user_id: user_moderator.id)
      visit '/'
      expect(page).to have_link('Ideat')
      expect(page).to have_link('UKK')
      expect(page).to have_link('Tägit')
      expect(page).not_to have_link('Käyttäjät')
      expect(page).to have_link('Kirjaudu ulos')
    end

    it 'while user is admin' do
      page.set_rack_session(user_id: user_admin.id)
      visit '/'
      expect(page).to have_link('Ideat')
      expect(page).to have_link('UKK')
      expect(page).not_to have_link('Tägit')
      expect(page).to have_link('Käyttäjät')
      expect(page).to have_link('Kirjaudu ulos')
    end
  end
end
