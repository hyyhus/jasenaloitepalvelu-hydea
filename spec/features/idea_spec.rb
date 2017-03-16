require 'rails_helper'
require 'spec_helper'

RSpec.describe 'IdeaFeature', type: :feature do
  let!(:user_moderator){ FactoryGirl.create(:user_moderator) }
  let!(:idea){ FactoryGirl.create(:idea) }
  let!(:user){ FactoryGirl.create(:user) }

  it 'goes to page' do
    visit '/'
    expect(page).to have_current_path('/ideas?basket=Approved')
  end

  it 'goes to new ideas' do
    page.set_rack_session(:user_id => user_moderator.id)
    visit '/ideas?basket=New'
    expect(page).to have_content('idea topic')
  end

  describe 'idea is published' do
    before :each do
      page.set_rack_session(:user_id => user_moderator.id)
      visit '/ideas?basket=New'
      click_link('Publish')
    end

    it 'publishes idea and check transferor' do
      expect(page).to have_current_path('/ideas?basket=Approved')
      expect(page).to have_content('idea topic')
      expect(page).to have_content(idea.histories.all.last.basket + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
    end

    it 'move idea to Changing and check transferor' do
      click_link('Changing')
      visit '/ideas?basket=Changing'
      expect(page).to have_current_path('/ideas?basket=Changing')
      expect(page).to have_content('idea topic')
      expect(page).to have_content(idea.histories.all.last.basket + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
    end

    it 'move idea to Changed and check transferor' do
      click_link('Changed')
      visit '/ideas?basket=Changed'
      expect(page).to have_current_path('/ideas?basket=Changed')
      expect(page).to have_content('idea topic')
      expect(page).to have_content(idea.histories.all.last.basket + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
    end

    it 'move idea to Not Changed and check transferor' do
      click_link('Not Changed')
      visit '/ideas?basket=Not+Changed'
      expect(page).to have_current_path('/ideas?basket=Not+Changed')
      expect(page).to have_content('idea topic')
      expect(page).to have_content(idea.histories.all.last.basket + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
    end

    context 'idea is changing' do
      before :each do
        click_link('Changing')
        visit '/ideas?basket=Changing'
      end

      it 'move idea to Changed and check transferor' do
        click_link('Changed')
        visit '/ideas?basket=Changed'
        expect(page).to have_current_path('/ideas?basket=Changed')
        expect(page).to have_content('idea topic')
        expect(page).to have_content(idea.histories.all.last.basket + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
      end

      it 'move idea to Not Changed and check transferor' do
        click_link('Not Changed')
        visit '/ideas?basket=Not+Changed'
        expect(page).to have_current_path('/ideas?basket=Not+Changed')
        expect(page).to have_content('idea topic')
        expect(page).to have_content(idea.histories.all.last.basket + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
      end
    end
  end

  it 'rejects idea and check transferor' do
    page.set_rack_session(:user_id => user_moderator.id)
    visit '/ideas?basket=New'
    click_link('Reject')
    expect(page).to have_current_path('/ideas?basket=Approved')
    expect(page).to_not have_content('idea topic')
    visit '/ideas?basket=Rejected'
    expect(page).to have_content('idea topic')
    expect(page).to have_content(idea.histories.all.last.basket + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
  end

  # Test for all baskets
  it 'when user not logged in' #do
  #  page.set_rack_session(:user_id => user.id)
  #  visit '/ideas?basket=New'
  #  expect(page).to have_current_path('/ideas?basket=Approved')
  #end
end
