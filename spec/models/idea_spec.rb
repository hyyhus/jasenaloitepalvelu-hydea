require 'rails_helper'

RSpec.describe Idea, type: :model do
  it "has new basket created correctly" do
  	basket = Basket.new id:500, name:"Test"
  	idea = Idea.new topic:"Testing", basket_id:500
  	idea.basket = basket  	
  	expect(idea.basket.id).to eq(500)
  end
end
