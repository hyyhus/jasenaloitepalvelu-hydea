require 'rails_helper'

RSpec.describe IdeasController, :type => :controller do
    let(:user){ FactoryGirl.create(:user) }
    let(:user_admin){ FactoryGirl.create(:user_admin) }
    let(:user_moderator){ FactoryGirl.create(:user_moderator) }

  it "can be published by moderator" do
    session[:user_id] = :user_moderator
    idea = FactoryGirl.create(:idea)
    # Correct way to use publish is missing
    # expect(idea.histories.last.basket).to eq("Approved")
  end

#TODO
  it "cannot be published by non-moderator" do
    idea = FactoryGirl.create(:idea)
  end

  it "cannot be updated if not signed it or whatnot wrong test" do
    idea = FactoryGirl.create(:idea)
  end
end