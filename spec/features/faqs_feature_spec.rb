require 'rails_helper'
require 'spec_helper'

RSpec.feature 'Faqs', type: :feature do
  context 'change' do
    it 'when language button is pressed' do
      page.set_rack_session(locale: 'fin')
      @faqfin = FactoryGirl.create(:faq, language: 'fin', text: 'ukk teksti')
      @faqeng = FactoryGirl.create(:faq, language: 'en', text: 'faq english')
      @faqswe = FactoryGirl.create(:faq, language: 'swe', text: 'faq svensk')
      visit '/faq'

      expect(page).to have_content('Usein kysytyt kysymykset')
      expect(page).to have_content('ukk teksti')
      find(:xpath, "//a[@href='/language/english']").click
      expect(page).to have_content('Frequently asked questions')
      expect(page).to have_content('faq english')
      find(:xpath, "//a[@href='/language/swedish']").click
      expect(page).to have_content('Vanliga Fragor')
      expect(page).to have_content('faq svensk')
      find(:xpath, "//a[@href='/language/finnish']").click
      expect(page).to have_content('Usein kysytyt kysymykset')
      expect(page).to have_content('ukk teksti')
      find(:xpath, "//a[@href='/language/swedish']").click
      expect(page).to have_content('Vanliga Fragor')
      expect(page).to have_content('faq svensk')
      find(:xpath, "//a[@href='/language/english']").click
      expect(page).to have_content('Frequently asked questions')
      expect(page).to have_content('faq english')
      find(:xpath, "//a[@href='/language/finnish']").click
      expect(page).to have_content('Usein kysytyt kysymykset')
      expect(page).to have_content('ukk teksti')
    end
  end

  describe "don't change" do
    context 'when language link' do
      it 'Finnish is pressed twice' do
        page.set_rack_session(locale: 'fin')
        @faqfin = FactoryGirl.create(:faq, language: 'fin', text: 'ukk teksti')
        @faqeng = FactoryGirl.create(:faq, language: 'en', text: 'faq english')
        @faqswe = FactoryGirl.create(:faq, language: 'swe', text: 'faq svensk')
        visit '/faq'
        find(:xpath, "//a[@href='/language/finnish']").click
        expect(page).to have_content('Usein kysytyt kysymykset')
        expect(page).not_to have_content('Frequently asked questions')
        expect(page).not_to have_content('Vanliga Fragor')
      end

      it 'English is pressed twice' do
        page.set_rack_session(locale: 'en')
        @faqfin = FactoryGirl.create(:faq, language: 'fin', text: 'ukk teksti')
        @faqeng = FactoryGirl.create(:faq, language: 'en', text: 'faq english')
        @faqswe = FactoryGirl.create(:faq, language: 'swe', text: 'faq svensk')
        visit '/faq'
        find(:xpath, "//a[@href='/language/english']").click
        expect(page).not_to have_content('Usein kysytyt kysymykset')
        expect(page).to have_content('Frequently asked questions')
        expect(page).not_to have_content('Vanliga Fragor')
      end

      it 'Swedish is pressed twice' do
        page.set_rack_session(locale: 'swe')
        @faqfin = FactoryGirl.create(:faq, language: 'fin', text: 'ukk teksti')
        @faqeng = FactoryGirl.create(:faq, language: 'en', text: 'faq english')
        @faqswe = FactoryGirl.create(:faq, language: 'swe', text: 'faq svensk')
        visit '/faq'
        find(:xpath, "//a[@href='/language/swedish']").click
        expect(page).not_to have_content('Usein kysytyt kysymykset')
        expect(page).not_to have_content('Frequently asked questions')
        expect(page).to have_content('Vanliga Fragor')
      end
    end
  end

  describe 'Markdown is rendered' do
    it 'should have link in english' do
      page.set_rack_session(locale: 'en')
      @faqfin = FactoryGirl.create(:faq, language: 'fin', text: 'ukk teksti')
      @faqeng = FactoryGirl.create(:faq, language: 'en', text: 'faq english [google](www.google.com)')
      @faqswe = FactoryGirl.create(:faq, language: 'swe', text: 'faq svensk')
      visit '/faq'
      expect(page).to have_selector(:link_or_button, 'google')
    end

    it 'should have h2 in english' do
      page.set_rack_session(locale: 'en')
      @faqfin = FactoryGirl.create(:faq, language: 'fin', text: 'ukk teksti')
      @faqeng = FactoryGirl.create(:faq, language: 'en', text: '## HEADER2')
      @faqswe = FactoryGirl.create(:faq, language: 'swe', text: 'faq svensk')
      visit '/faq'
      expect(page.html).to include('<h2>HEADER2</h2>')
    end
  end
end
