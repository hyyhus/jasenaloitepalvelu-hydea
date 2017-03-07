require 'rails_helper'

RSpec.describe Comment, type: :model do

describe "user and idea exist" do
	let(:user){FactoryGirl.create(:user, name: "Testi Tauno")}
	let(:comment){FactoryGirl.create(:comment, user: user, text: "comment text")}

    it "has factory make comment with all" do
        expect(comment.user.name).to eq("Testi Tauno")
        expect(comment.time).not_to be_nil
        expect(comment.text).to eq("comment text")
    end
    

end
end
