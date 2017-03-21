require 'rails_helper'

RSpec.describe History, type: :model do
	let(:history_new){ FactoryGirl.create(:history_new) }
	let(:history_without_basket){ FactoryGirl.build(:history_without_basket) }

  it "is valid with history set" do  	
  	expect(history_new).to be_valid
  	expect(history_new.time).to eq("2016-07-04 00:00:00.000000000 +0300")
  end

  it "has user set" do
    expect(history_new.user.name).to eq("Testi Tauno")
  end

  it "is not valid without basket set" do
  	expect(history_without_basket).not_to be_valid
  end

  it "is not valid without user set" do
  	history_new.user = nil
  	expect(history_new).not_to be_valid
  end

  describe "baskets" do
	  it "is valid with basket Approved" do
		  history_new.basket = "Approved"
		  expect(history_new).to be_valid
	  end
	  it "is valid with basket Changing" do
		  history_new.basket = "Changing"
		  expect(history_new).to be_valid
	  end
	  it "is valid with basket Changed" do
		  history_new.basket = "Changed"
		  expect(history_new).to be_valid
	  end
	  it "is valid with basket Not Changed" do
		  history_new.basket = "Not Changed"
		  expect(history_new).to be_valid
	  end
	  it "is valid with basket Rejected" do
		  history_new.basket = "Rejected"
		  expect(history_new).to be_valid
	  end
	  it "is not valid with some other basket name" do
		  history_new.basket = "Not allowed"
		  expect(history_new).not_to be_valid
	  end
  end  

end
