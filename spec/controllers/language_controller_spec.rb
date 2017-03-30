require 'rails_helper'

RSpec.describe LanguageController, type: :controller do

  describe "GET #english" do
    it "returns http success" do
      get :english
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #finnish" do
    it "returns http success" do
      get :finnish
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #swedish" do
    it "returns http success" do
      get :swedish
      expect(response).to have_http_status(:success)
    end
  end

end
