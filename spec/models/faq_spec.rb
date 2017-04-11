require 'rails_helper'

RSpec.describe Faq, type: :model do

  it 'has factory make faq' do
    faq = FactoryGirl.create(:faq)
    expect(faq.language).to eq('language')
    expect(faq.text).to eq('text')
  end

  it 'has factory not to make faq without language' do
    faq = FactoryGirl.build(:faq, language: '')
    expect(faq).not_to be_valid
  end

  it 'has factory not to make faq without text' do
    faq = FactoryGirl.build(:faq, text: '')
    expect(faq).not_to be_valid
  end
end
