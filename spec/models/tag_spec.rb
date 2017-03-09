require 'rails_helper'

RSpec.describe Tag, type: :model do
	let(:tag){ FactoryGirl.create(:tag) }

  it "create tag with text" do
    expect(tag.ideas).to be_empty
  end

  it "create tag with multiple ideas" do
  	idea1 = FactoryGirl.create(:idea, tags:[])
  	idea2 = FactoryGirl.create(:idea, tags:[])
  	tag.ideas << idea1
  	tag.ideas << idea2
  	expect(tag.ideas.count).to eq(2)
  end

  it "do not create empty tag" do
  	tag_invalid = FactoryGirl.build(:tag, text:"")
  	expect(tag_invalid).not_to be_valid
  end

  it "do not create duplicates" do
  	tag1 = Tag.create text:"Kumpula"
  	tag2 = Tag.create text:"Kumpula"
  	expect(Tag.count).to eq(1)
  end

end