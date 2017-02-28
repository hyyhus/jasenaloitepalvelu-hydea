require 'rails_helper'

RSpec.describe Idea, type: :model do
  it "has factory make idea with all" do
    idea = FactoryGirl.create(:idea)    
    idea.likes << FactoryGirl.create(:like, idea_id: idea.id)
    expect(idea.likes).not_to be_empty  
    expect(idea.histories).not_to be_empty      
    expect(idea.tags).not_to be_empty
  end
end
