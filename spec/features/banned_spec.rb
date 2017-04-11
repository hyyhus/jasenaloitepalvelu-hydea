require 'rails_helper'
require 'spec_helper'

RSpec.feature "Banned user", type: :feature do
  let!(:user) { FactoryGirl.create(:user_banned) }
  let!(:ideaone) { FactoryGirl.create(:idea_approved) }

  before :each do
    page.set_rack_session(user_id: user.id)
    page.visit ideas_path
  end

  it "can not add comments"

  it "can not like ideas" do
    click_on('0')
    expect(page).not_to have_selector(:link_or_button, '1')
  end

  it "can not add ideas"

end
