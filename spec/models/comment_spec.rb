require 'rails_helper'

RSpec.describe Comment, type: :model do

describe "user and idea exist" do

    it "has factory make comment with all" do
        comment = FactoryGirl.create(:comment)        
        expect(comment.user.name).to eq("Testi Tauno")
        expect(comment.time).not_to be_nil
        expect(comment.text).to eq("comment text")
    end
    

end
end