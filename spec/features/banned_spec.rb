require 'rails_helper'
require 'spec_helper'

RSpec.feature "Banned user", type: :feature do
    let!(:user) { FactoryGirl.create(:user_banned) }
    let!(:ideaone) { FactoryGirl.create(:idea_approved) }

    before :each do
      page.set_rack_session(user_id: user.id)
      page.visit ideas_path
    end

  it "can not add comments" do
    page.fill_in 'comment', :with => 'This will be nice'
    click_on('Send')
    expect(page).not_to have_content('This will be nice')
  end

    it "can not like ideas" do
			click_on('0')
			expect(page).not_to have_selector(:link_or_button, '1')
    end

  it "can not add ideas" do
    click_on('Lisää idea')
    expect(current_path).not_to be('/ideas/new')
  end
  
  it "can not access user listings" do 
    click_on('Käyttäjät')
    expect(current_path).not_to be('/users')

  end

end
