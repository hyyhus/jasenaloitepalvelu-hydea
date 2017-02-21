require 'rails_helper'

RSpec.describe Basket, type: :model do
  it "has factory make basket with all" do
    basket = FactoryGirl.create(:basket)
  end
end