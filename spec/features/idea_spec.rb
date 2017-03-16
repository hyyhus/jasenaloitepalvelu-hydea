require 'rails_helper'

RSpec.describe "idea", :type => :feature do
  let(:user_moderator){ FactoryGirl.create(:user_moderator) }
  let(:idea){ FactoryGirl.create(:idea) }

  it 'goes to page' do
    visit '/'
    page.should have_content('Listing Ideas')
  end

  it "make new idea" do
    #idea = FactoryGirl.create(:idea)
    #session[:user_id] = user_moderator.id
    expect(idea.histories.first.basket).to eq("New")
    visit '/ideas?basket=Approved'
    #byebug
  end

  describe IdeasController, type: :controller do
    let(:user_moderator){ FactoryGirl.create(:user_moderator) }
    let(:idea){ FactoryGirl.create(:idea) }
    #session[:user_id] = user_moderator.id

    it 'go to new ideas' do
      #session[:user_id] = user_moderator.id
      #visit '/ideas?basket=Approve'
      page.set_rack_session(:user_id => user_moderator.id)
      idea = idea
      visit '/users/'
      visit '/ideas?basket=Approve'
      puts page.body
      byebug
      page.should have_content('Listing Ideas')
    end

  end
end
