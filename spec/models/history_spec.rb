require 'rails_helper'

RSpec.describe History, type: :model do
	let(:history_new){ FactoryGirl.create(:history_new) }
	let(:history_without_basket){ FactoryGirl.build(:history_without_basket) }

  it "is valid, has basket New and has time" do  	
  	expect(history_new).to be_valid
  	expect(history_new.time).to eq("2016-07-04 00:00:00.000000000 +0300")
  end

  it "has user" do
    expect(history_new.user.name).to eq("Testi Tauno")
  end

  it "without basket is not created" do
  	expect(history_without_basket).not_to be_valid
  end

  it "without user is not created" do
  	history_new.user = nil
  	expect(history_new).not_to be_valid
  end

end