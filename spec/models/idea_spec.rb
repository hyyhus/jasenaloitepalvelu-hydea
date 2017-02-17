require 'rails_helper'

RSpec.describe Idea, type: :model do
  it "has factory make idea with all" do
    idea = FactoryGirl.create(:idea)
    expect(idea.basket).not_to be_nil
    expect(idea.basket.ideas).not_to be_empty
    expect(idea.likes).not_to be_empty  
    expect(idea.histories).not_to be_empty      
    expect(idea.tags).not_to be_empty
  end
end
