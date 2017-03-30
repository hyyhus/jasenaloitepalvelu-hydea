require 'rails_helper'

RSpec.describe LanguageController, type: :controller do
  describe 'POST #english' do
    before :each do
      @request.env['HTTP_REFERER'] = root_path
    end

    it 'changes locale to English' do
      post :english
      expect(I18n.locale).to eq(:en)
    end

    it 'does not change current page' do
      post :english
      expect redirect_to eq(@request.env['HTTP_REFERER'])
    end
  end

  describe 'POST #finnish' do
    before :each do
      @request.env['HTTP_REFERER'] = root_path
    end

    it 'changes locale to Finnish' do
      post :finnish
      expect(I18n.locale).to eq(:fin)
    end
    
    it 'does not change current page' do
      post :finnish
      expect redirect_to eq(@request.env['HTTP_REFERER'])
    end
  end

  describe 'POST #swedish' do
    before :each do
      @request.env['HTTP_REFERER'] = root_path
    end 
    
    it 'changes locale to Swedish' do
      post :swedish
      expect(I18n.locale).to eq(:swe)
    end

    it 'does not change current page' do
      post :swedish
      expect redirect_to eq(@request.env['HTTP_REFERER'])
    end
  end

end
