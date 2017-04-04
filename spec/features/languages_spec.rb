require 'rails_helper'
require 'spec_helper'

RSpec.feature 'Languages', type: :feature do
  context 'change' do
    it 'when language button is pressed' do
      visit '/'
      expect(page).to have_content('Ideat')
      find(:xpath, "//a[@href='/language/english']").click
      expect(page).to have_content('Ideas')
      find(:xpath, "//a[@href='/language/swedish']").click
      expect(page).to have_content('Idéer')
      find(:xpath, "//a[@href='/language/finnish']").click
      expect(page).to have_content('Ideat')
      find(:xpath, "//a[@href='/language/swedish']").click
      expect(page).to have_content('Idéer')
      find(:xpath, "//a[@href='/language/english']").click
      expect(page).to have_content('Ideas')
      find(:xpath, "//a[@href='/language/finnish']").click
      expect(page).to have_content('Ideat')
    end
  end
  describe "don't change" do
    context 'when language link' do
      it 'Finnish is pressed twice' do
        visit '/'
        expect(page).to have_content('Ideat')
        find(:xpath, "//a[@href='/language/finnish']").click
        expect(page).to have_content('Ideat')
        # expect(page).not_to have_content('Ideas')
        # poista kommentti kun lokalisaatio tehty
        expect(page).not_to have_content('Idéer')
      end

      it 'English is pressed twice' do
        visit '/'
        find(:xpath, "//a[@href='/language/english']").click
        expect(page).to have_content('Ideas')
        find(:xpath, "//a[@href='/language/english']").click
        expect(page).not_to have_content('Ideat')
        expect(page).to have_content('Ideas')
        expect(page).not_to have_content('Idéer')
      end

      it 'Swedish is pressed twice' do
        visit '/'
        find(:xpath, "//a[@href='/language/swedish']").click
        expect(page).to have_content('Idéer')
        find(:xpath, "//a[@href='/language/swedish']").click
        expect(page).not_to have_content('Ideat')
        # expect(page).not_to have_content('Ideas')
        # poista kommentti kun lokalisaatio tehty
        expect(page).to have_content('Idéer')
      end
    end
  end
end
