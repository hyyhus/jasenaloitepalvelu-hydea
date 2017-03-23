require 'rails_helper'
require 'spec_helper'

RSpec.describe 'IdeaFeature', type: :feature do
  let!(:user_moderator){ FactoryGirl.create(:user_moderator) }
  let!(:idea){ FactoryGirl.create(:idea) }
  let!(:user){ FactoryGirl.create(:user) }

  describe 'visiting pages' do
      it 'approved page is accessible' do
      visit '/'
      expect(page).to have_current_path('/ideas?basket=Approved')
  end

      it 'new ideas page is accessible when moderator' do
      page.set_rack_session(:user_id => user_moderator.id)
      visit '/ideas?basket=New'
      expect(page).to have_content('idea topic')
    end

  end

  describe 'idea basket actions for moderators' do
    before :each do
      page.set_rack_session(:user_id => user_moderator.id)
      visit '/ideas?basket=New'
      click_link('Publish')
    end

  context 'when an ideas status is published' do
    it 'shows as published and shows who moved it' do
      expect(page).to have_current_path('/ideas?basket=Approved')
      expect(page).to have_content('idea topic')
      expect(page).to have_content(idea.histories.all.last.basket + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
    end

    it 'moves to changing when clicked and shows who moved it' do
      click_link('Changing')
      visit '/ideas?basket=Changing'
      expect(page).to have_current_path('/ideas?basket=Changing')
      expect(page).to have_content('idea topic')
      expect(page).to have_content(idea.histories.all.last.basket + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
    end

    it 'moves to changed when clicked and shows who moved it' do
      click_link('Changed')
      visit '/ideas?basket=Changed'
      expect(page).to have_current_path('/ideas?basket=Changed')
      expect(page).to have_content('idea topic')
      expect(page).to have_content(idea.histories.all.last.basket + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
    end

    it 'moves to not changed when clicked and shows who moved it' do
      click_link('Not Changed')
      visit '/ideas?basket=Not+Changed'
      expect(page).to have_current_path('/ideas?basket=Not+Changed')
      expect(page).to have_content('idea topic')
      expect(page).to have_content(idea.histories.all.last.basket + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
    end
  end

    context 'when an ideas status is changing' do
      before :each do
        click_link('Changing')
        visit '/ideas?basket=Changing'
      end

      it 'moves to changed when clicked and shows who moved it' do
        click_link('Changed')
        visit '/ideas?basket=Changed'
        expect(page).to have_current_path('/ideas?basket=Changed')
        expect(page).to have_content('idea topic')
        expect(page).to have_content(idea.histories.all.last.basket + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
      end

      it 'moves to not changed and shows who moved it' do
        click_link('Not Changed')
        visit '/ideas?basket=Not+Changed'
        expect(page).to have_current_path('/ideas?basket=Not+Changed')
        expect(page).to have_content('idea topic')
        expect(page).to have_content(idea.histories.all.last.basket + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
      end
    end
  end

    context 'when it has new status' do
      it 'moves to rejected when clicked and shows who moved it' do
        page.set_rack_session(:user_id => user_moderator.id)
        visit '/ideas?basket=New'
        click_link('Reject')
        expect(page).to have_current_path('/ideas?basket=Approved')
        expect(page).to_not have_content('idea topic')
        visit '/ideas?basket=Rejected'
        expect(page).to have_content('idea topic')
        expect(page).to have_content(idea.histories.all.last.basket + ': ' + idea.histories.all.last.time.strftime('%d.%m.%Y %H:%M ') + ' ' + user_moderator.name + ' (' + user_moderator.title + ')')
    end
      end

  it 'redirects basket New when not moderator' do
    page.set_rack_session(:user_id => user.id)
    visit '/ideas?basket=New'
    expect(page).to have_current_path('/ideas?basket=Approved')
  end

  it 'redirects basket Rejected when not moderator' do
    page.set_rack_session(:user_id => user.id)
    visit '/ideas?basket=Rejected'
    expect(page).to have_current_path('/ideas?basket=Approved')
  end

  describe 'link to idea' do
    before :each do
      page.set_rack_session(:user_id => user_moderator.id)
      visit '/ideas?basket=New'
    end

    context 'is not shown' do
      it 'while basket is New' do
        expect(page).to have_current_path('/ideas?basket=New')
        expect(page).to have_no_selector(:css, 'a[title="Show idea"]')
      end
      it 'while basket is Rejected' do
        click_link('Reject')
        visit '/ideas?basket=Reject'
        expect(page).to have_no_selector(:css, 'a[title="Show idea"]')
      end
    end

    context 'is shown' do
      before :each do
        click_link('Publish')
        expect(page).to have_current_path('/ideas?basket=Approved')
      end

      it 'while basket is Approved' do
        find(:css, 'a[title="Show idea"]').click
        expect(page).to have_current_path('/ideas/1')
      end

      it 'while basket is Changing' do
        click_link('Changing')
        visit '/ideas?basket=Changing'
        find(:css, 'a[title="Show idea"]').click
        expect(page).to have_current_path('/ideas/1')
      end

      it 'while basket is Changed' do
        click_link('Changed')
        visit '/ideas?basket=Changed'
        find(:css, 'a[title="Show idea"]').click
        expect(page).to have_current_path('/ideas/1')
      end

      it 'while basket is Not Changed' do
        click_link('Not Changed')
        visit '/ideas?basket=Not+Changed'
        find(:css, 'a[title="Show idea"]').click
        expect(page).to have_current_path('/ideas/1')
      end
    end
  end
end
