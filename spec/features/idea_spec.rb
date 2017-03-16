require 'rails_helper'
require 'spec_helper'

RSpec.describe 'IdeaFeature', type: :feature do
  let(:user_moderator){ FactoryGirl.create(:user_moderator) }
  let!(:idea){ FactoryGirl.create(:idea) }

  it 'goes to page' do
    visit '/'
    expect(page).to have_current_path('/ideas?basket=Approved')
  end

  it 'goes to new ideas' do
    page.set_rack_session(:user_id => user_moderator.id)
    visit '/ideas?basket=New'
    expect(page).to have_content('idea topic')
  end

  it 'publishes idea and check transferor' do
    page.set_rack_session(:user_id => user_moderator.id)
    visit '/ideas?basket=New'
    click_link('Publish')
    expect(page).to have_current_path('/ideas?basket=Approved')
    expect(page).to have_content('idea topic')
    expect(page).to have_content(user_moderator.name + ' (' + user_moderator.title + ')')
  end
end
