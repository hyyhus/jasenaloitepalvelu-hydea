require 'rails_helper'

RSpec.describe User, type: :model do
    let(:user){ FactoryGirl.create(:user) }
    let(:user_with_history){ FactoryGirl.create(:user_with_history) }
    let(:user_admin){ FactoryGirl.create(:user_admin) }
    let(:user_moderator){ FactoryGirl.create(:user_moderator) }

  it "has factory make user with all" do    
    user.comments << FactoryGirl.create(:comment, user_id: user.id)
    #user.likes << FactoryGirl.create(:like, user_id: user.id)
    expect(user.name).to eq("Testi Tauno")
    expect(user.email).to eq("testi@blaa.fi")
    expect(user.admin).to be false
    expect(user.moderator).to be false
    expect(user.title).to eq("opiskelija")
    expect(user.persistent_id).not_to be_empty
    expect(user.comments).not_to be_empty
    #expect(user.likes).not_to be_empty
  end

  it "not created if duplicate persistent_id" do
    user20 = User.create name:"Test", persistent_id:"9876543"
    user30 = User.create name:"Test2", persistent_id:"9876543"    
    expect(User.count).to eq(1)
  end

  it "has history with basket New" do    
    expect(user_with_history.histories.first.basket).to eq("New")
    expect(user_with_history.histories.count).to eq(1)

  end

  it "admin is created correctly" do
    expect(user_admin.admin).to be true
  end

  it "moderator is created correctly" do
    expect(user_moderator.moderator).to be true
  end



  describe "without a" do    
    it "name is not created" do
        user = FactoryGirl.create(:user)
        user.name = nil
        expect(user).not_to be_valid
    end

    it "persistent_id is not created" do        
        user = FactoryGirl.create(:user)
        user.persistent_id = nil
        expect(user).not_to be_valid
    end
  end
end
