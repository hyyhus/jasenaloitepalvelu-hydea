require 'rails_helper'
require 'spec_helper'

RSpec.feature 'Export', type: :feature do
  context 'Non-moderator' do
    let!(:idea) { FactoryGirl.create(:idea) }
    let!(:user) { FactoryGirl.create(:user) }

    it 'cannot see button' do
      page.set_rack_session(user_id: user.id)
      visit '/'
      expect(page).not_to have_content('Vie tiedostoon')
      visit '/export.csv'
      expect(page).not_to eq '/export.csv'
    end

    it 'cannot access function' do
      page.set_rack_session(user_id: user.id)
      visit '/export.csv'
      expect(page.current_path).to eq '/ideas'
    end
  end

  context 'Moderator' do
    let!(:user_moderator) { FactoryGirl.create(:user_moderator) }
    let!(:idea) { FactoryGirl.create(:idea) }

    it 'can see button' do
      page.set_rack_session(user_id: user_moderator.id)
      visit '/'
      expect(page).to have_content('Vie tiedostoon')
    end

    it 'can access function' do
      page.set_rack_session(user_id: user_moderator.id)
      visit '/export.csv'
      expect(page.current_path).to eq '/export.csv'
    end
  end
end
