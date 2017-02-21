require 'rails_helper'

RSpec.describe History, type: :model do
  it "has factory make history with all" do
    history = FactoryGirl.create(:history)
  end
end