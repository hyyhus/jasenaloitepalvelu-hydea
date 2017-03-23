require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
	#	in integration environment this is allowed...
#	describe "POST #create" do
#		it "is not allowed" do
#			expect{post :create, params: { persistent_id: FactoryGirl.attributes_for(:user) }}.to raise_error(ActionController::UrlGenerationError)
#		end
#	end

	describe "DELETE #destroy" do
		it "removes session" do
		user = FactoryGirl.create(:user)
		session[:user_id] = user.id
		delete :destroy
		expect(session[:user_id]).to be_nil
		end
	end

end
