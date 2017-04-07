require 'rails_helper'
require 'spec_helper'

RSpec.feature "Filters", type: :feature do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:ideaone) { FactoryGirl.create(:idea_approved, topic: "First idea") }
  let!(:ideatwo) { FactoryGirl.create(:idea_approved, topic: "Second idea") }
  let!(:kumpula) {FactoryGirl.create(:tag, text: "Kumpula")}
  let!(:viikki) {FactoryGirl.create(:tag, text: "Viikki")}
  let!(:juhlat) {FactoryGirl.create(:tag, text: "Juhlat")}

      before :each do
        page.set_rack_session(user_id: user.id)
        ideaone.tags << kumpula
        ideatwo.tags << viikki
      end

      it "with no filters set all ideas are shown" do
        page.visit ideas_path
        expect(page).to have_content("First idea")
        expect(page).to have_content("Second idea")
        expect(find('input[value="Kumpula"]')).not_to be_checked
        expect(find('input[value="Viikki"]')).not_to be_checked
        expect(find('input[value="Juhlat"]')).not_to be_checked
        expect(page).to have_content("First idea")
        expect(page).to have_content("Second idea")

      end

  it "filtering with one tag hides the other idea" do
    page.visit ideas_path
    expect(page).to have_content("First idea")
    expect(page).to have_content("Second idea")
    find('input[value="Kumpula"]').set(true)    
    click_button("Suodata")
    expect(page).to have_content("First idea")
    expect(page).not_to have_content("Second idea")
  end

  it "filtering with both tags show both ideas" do
    page.visit ideas_path
    expect(page).to have_content("First idea")
    expect(page).to have_content("Second idea")
    find('input[value="Kumpula"]').set(true)    
    find('input[value="Viikki"]').set(true)    
    click_button("Suodata")
    expect(page).to have_content("First idea")
    expect(page).to have_content("Second idea")
  end

  it "filtering with missing tag shows neither idea" do
    page.visit ideas_path
    expect(page).to have_content("First idea")
    expect(page).to have_content("Second idea")
    find('input[value="Juhlat"]').set(true)    
    click_button("Suodata")
    expect(page).not_to have_content("First idea")
    expect(page).not_to have_content("Second idea")
  end

  it "idea with multiple tags is still shown with one filter hit" do
    ideaone.tags << juhlat
    page.visit ideas_path
    expect(page).to have_content("First idea")
    expect(page).to have_content("Second idea")
    find('input[value="Juhlat"]').set(true)    
    click_button("Suodata")
    expect(page).to have_content("First idea")
    expect(page).not_to have_content("Second idea")
  end

  it "only idea fitting filters is shown with multiple hits" do
    ideaone.tags << juhlat
    page.visit ideas_path
    expect(page).to have_content("First idea")
    expect(page).to have_content("Second idea")
    find('input[value="Juhlat"]').set(true)    
    find('input[value="Kumpula"]').set(true)    
    click_button("Suodata")
    expect(page).to have_content("First idea")
    expect(page).not_to have_content("Second idea")
  end

end
