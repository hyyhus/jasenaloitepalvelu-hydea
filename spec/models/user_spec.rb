require 'rails_helper'

RSpec.describe User, type: :model do

  it "has factory make user with all" do
    user = FactoryGirl.create(:user)
    user.comments << FactoryGirl.create(:comment, user_id: user.id)
    user.likes << FactoryGirl.create(:like, user_id: user.id)
    expect(user.name).to eq("Testi Tauno")
    expect(user.email).to eq("testi@blaa.fi")
    expect(user.admin).to be false
	  expect(user.moderator).to be false
    expect(user.title).to eq("opiskelija")
    expect(user.persistent_id).to eq("9876543")
    expect(user.comments).not_to be_empty
    expect(user.likes).not_to be_empty
  end
end
