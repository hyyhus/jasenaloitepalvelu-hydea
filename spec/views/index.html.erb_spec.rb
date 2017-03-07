require 'rails_helper'

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :should}
end

describe "ideas/index.html.erb", type: :view do
  before do
    idea = FactoryGirl.create(:idea)
    user = FactoryGirl.create(:user, name: "Testi Tauno", moderator: true, title: "moderator")
    FactoryGirl.create(:comment, user: user, text: "comment text", idea_id: 1)
    user = FactoryGirl.create(:user, name: "Testi Tauno", moderator: false, title: "not moderator")
    FactoryGirl.create(:comment, user: user, text: "comment text", idea_id: 1)
    @ideas = Idea.all
    render
  end

  it "displays moderator title" do
    rendered.should match('(moderator)')
  end

  it "doesn't display non-moderator title" do
    rendered.should_not match('(not moderator)')
  end

end
