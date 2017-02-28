require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "has factory make tag with name" do
    tag = FactoryGirl.create(:tag)
    expect(tag.ideas).to be_empty
  end

 # it "has factory make tag with ideas" do
 #   tag = FactoryGirl.create(:tag_has_many_ideas)
 #   expect(tag.ideas).not_to be_empty
 # end
end