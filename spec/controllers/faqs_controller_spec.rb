require 'rails_helper'

RSpec.describe FaqsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_admin) { FactoryGirl.create(:user_admin) }
  let(:user_moderator) { FactoryGirl.create(:user_moderator) }
  let(:user_student) { FactoryGirl.create(:user_student, id: 2) }

  describe 'POST #update' do
    it 'faq is updated by moderator' do
      session[:user_id] = user_moderator.id
      @faq = FactoryGirl.create(:faq, language: 'en', text: 'faq text not to be updated')
      put :update, params: { id: @faq.id, faq: FactoryGirl.attributes_for(:faq, text: 'updated text') }
      @faq.reload
      expect(@faq.text).to eq('updated text')
    end

    context 'faq is not updated by moderator' do
      it 'without a text' do
        session[:user_id] = user_moderator.id
        @faq = FactoryGirl.create(:faq, language: 'en', text: 'faq text not to be updated')
        put :update, params: { id: @faq.id, faq: FactoryGirl.attributes_for(:faq, text: '') }
        @faq.reload
        expect(@faq.text).to eq('faq text not to be updated')
      end

      it 'without a language' do
        session[:user_id] = user_moderator.id
        @faq = FactoryGirl.create(:faq, language: 'en', text: 'faq text not to be updated')
        put :update, params: { id: @faq.id, faq: FactoryGirl.attributes_for(:faq, language: ' ') }
        @faq.reload
        expect(@faq.language).to eq('en')
      end
    end
    
    it 'cannot be updated if not moderator' do
      session[:user_id] = user.id
      @faq = FactoryGirl.create(:faq, language: 'en', text: 'faq text not to be updated')
      put :update, params: { id: @faq.id, faq: FactoryGirl.attributes_for(:faq, text: 'updated text') }
      @faq.reload
      expect(@faq.text).to eq('faq text not to be updated')
    end

    it 'cannot be updated if not signed in' do
      session[:user_id] = user.id
      @faq = FactoryGirl.create(:faq, language: 'en', text: 'faq text not to be updated')
      session[:user_id] = nil
      put :update, params: { id: @faq.id, faq: FactoryGirl.attributes_for(:faq, text: 'updated text') }
      @faq.reload
      expect(@faq.text).to eq('faq text not to be updated')
    end
  end

  context 'Basic user logged in' do
    describe 'GET #show' do
      it 'user views English faq' do
        session[:user_id] = user.id
        session[:locale] = 'en'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq english text')
        get :show, params: { id: @faq }
        expect(response).to render_template(:show)
      end

      it 'user views Finnish faq' do
        session[:user_id] = user.id
        session[:locale] = 'fin'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq finnish text')
        get :show, params: { id: @faq }
        expect(response).to render_template(:show)
      end

      it 'user views Swedish faq' do
        session[:user_id] = user.id
        session[:locale] = 'swe'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq swedish text')
        get :show, params: { id: @faq }
        expect(response).to render_template(:show)
      end
    end

    describe 'GET /faq' do
      it 'user views English faq' do
        session[:user_id] = user.id
        session[:locale] = 'en'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq english text')
        expect(get: '/faq').to route_to(controller: 'faqs', action: 'show')
      end

      it 'user views Finnish faq' do
        session[:user_id] = user.id
        session[:locale] = 'fin'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq finnish text')
        expect(get: '/faq').to route_to(controller: 'faqs', action: 'show')
      end

      it 'user views Swedish faq' do
        session[:user_id] = user.id
        session[:locale] = 'swe'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq swedish text')
        expect(get: '/faq').to route_to(controller: 'faqs', action: 'show')
      end
    end

    describe 'GET #index' do
      it 'user should not see page' do
        session[:user_id] = user.id
        session[:locale] = 'en'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq english text')
        get :index
        expect(response).to redirect_to ideas_path
      end
    end

    describe 'GET #new' do
      it 'user should not see page' do
        session[:user_id] = user.id
        get :new
        expect(response).to redirect_to ideas_path
      end
    end

    describe 'GET #create' do
      it 'user should not access page' do
        session[:user_id] = user.id
        get :create
        expect(response).to redirect_to ideas_path
      end
    end

    describe 'POST #destroy' do
      it 'user should not be able to delete' do
        session[:user_id] = user.id
        session[:locale] = 'swe'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq swedish text')
        expect { post :destroy, params: { id: @faq.id } }.not_to change(Faq, :count)
      end
    end
  end

  context 'Moderator user logged in' do
    describe 'GET #show' do
      it 'user views English faq' do
        session[:user_id] = user_moderator.id
        session[:locale] = 'en'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq english text')
        get :show, params: { id: @faq }
        expect(response).to render_template(:show)
      end

      it 'user views Finnish faq' do
        session[:user_id] = user_moderator.id
        session[:locale] = 'fin'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq finnish text')
        get :show, params: { id: @faq }
        expect(response).to render_template(:show)
      end

      it 'user views Swedish faq' do
        session[:user_id] = user_moderator.id
        session[:locale] = 'swe'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq swedish text')
        get :show, params: { id: @faq }
        expect(response).to render_template(:show)
      end
    end

    describe 'GET /faq' do
      it 'user views English faq' do
        session[:user_id] = user_moderator.id
        session[:locale] = 'en'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq english text')
        expect(get: '/faq').to route_to(controller: 'faqs', action: 'show')
      end

      it 'user views Finnish faq' do
        session[:user_id] = user_moderator.id
        session[:locale] = 'fin'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq finnish text')
        expect(get: '/faq').to route_to(controller: 'faqs', action: 'show')
      end

      it 'user views Swedish faq' do
        session[:user_id] = user_moderator.id
        session[:locale] = 'swe'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq swedish text')
        expect(get: '/faq').to route_to(controller: 'faqs', action: 'show')
      end
    end

    describe 'GET #index' do
      it 'moderator should see page' do
        session[:user_id] = user_moderator.id
        session[:locale] = 'en'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq english text')
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe 'GET #new' do
      it 'moderator should see page' do
        session[:user_id] = user_moderator.id
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe 'POST #create' do
      it 'moderator should be able to create' do
        session[:user_id] = user_moderator.id
        expect { post :create, params: { 'faq' => { 'language' => 'en', 'text' => 'faq text' } } }.to change(Faq, :count).by(1)
      end

      context 'moderator should not be able to create' do
        it 'without text' do
          session[:user_id] = user_moderator.id
          expect { post :create, params: { 'faq' => { 'language' => 'en', 'text' => '' } } }.not_to change(Faq, :count)
        end

        it 'without language' do
          session[:user_id] = user_moderator.id
          expect { post :create, params: { 'faq' => { 'language' => '', 'text' => 'text' } } }.not_to change(Faq, :count)
        end
      end
    end

    describe 'POST #destroy' do
      it 'moderator should be able to delete' do
        session[:user_id] = user_moderator.id
        session[:locale] = 'swe'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq swedish text')
        expect { post :destroy, params: { id: @faq.id } }.to change(Faq, :count).by(-1)
      end
    end
  end

  context 'User not logged in' do
    describe 'GET #show' do
      it 'user views English faq' do
        session[:user_id] = nil
        session[:locale] = 'en'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq english text')
        get :show, params: { id: @faq }
        expect(response).to render_template(:show)
      end

      it 'user views Finnish faq' do
        session[:user_id] = nil
        session[:locale] = 'fin'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq finnish text')
        get :show, params: { id: @faq }
        expect(response).to render_template(:show)
      end

      it 'user views Swedish faq' do
        session[:user_id] = nil
        session[:locale] = 'swe'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq swedish text')
        get :show, params: { id: @faq }
        expect(response).to render_template(:show)
      end
    end

    describe 'GET /faq' do
      it 'user views English faq' do
        session[:user_id] = nil
        session[:locale] = 'en'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq english text')
        expect(get: '/faq').to route_to(controller: 'faqs', action: 'show')
      end

      it 'user views Finnish faq' do
        session[:user_id] = nil
        session[:locale] = 'fin'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq finnish text')
        expect(get: '/faq').to route_to(controller: 'faqs', action: 'show')
      end

      it 'user views Swedish faq' do
        session[:user_id] = nil
        session[:locale] = 'swe'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq swedish text')
        expect(get: '/faq').to route_to(controller: 'faqs', action: 'show')
      end
    end

    describe 'GET #index' do
      it 'user should not see page' do
        session[:user_id] = nil
        session[:locale] = 'en'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq english text')
        get :index
        expect(response).to redirect_to ideas_path
      end
    end

    describe 'GET #new' do
      it 'user should not see page' do
        session[:user_id] = nil
        get :new
        expect(response).to redirect_to ideas_path
      end
    end

    describe 'GET #create' do
      it 'user should not access page' do
        session[:user_id] = nil
        get :create
        expect(response).to redirect_to ideas_path
      end
    end

    describe 'POST #destroy' do
      it 'user should not be able to delete' do
        session[:user_id] = nil
        session[:locale] = 'swe'
        @faq = FactoryGirl.create(:faq, language: :locale, text: 'faq swedish text')
        expect { post :destroy, params: { id: @faq.id } }.not_to change(Faq, :count)
      end
    end
  end
end
