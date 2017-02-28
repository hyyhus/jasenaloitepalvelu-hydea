require 'rails_helper'

RSpec.describe Like, type: :model do
  it "has factory make like with all" do
    like = FactoryGirl.create(:like)
  end
end