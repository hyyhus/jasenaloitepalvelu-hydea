require 'rails_helper'

RSpec.describe Comment, type: :model do

describe "user and idea exist" do

    before :each do
    @user = FactoryGirl.create(:user)
    @idea = FactoryGirl.create(:idea)
    
    end

    it "has factory make comment with all" do
        comment = FactoryGirl.create(:comment)
        comment.user = @user
        comment.idea = @idea
        expect(comment.time).not_to be_nil
        expect(comment.text).to eq("comment text")
    end
    

end
end