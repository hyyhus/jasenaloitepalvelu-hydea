require 'rails_helper'

RSpec.describe HistoriesController, type: :controller do
	let(:history){FactoryGirl.build(:history)}

	context "With normal user" do
		before :each do
			session[:user_id] = FactoryGirl.create(:user_student)
		end
		it "does not allow create" do
			expect{post :create, params: {history: history.attributes}
			}.not_to change(History,:count)
		end
		it "does not allow edit" do
			history.save
			expect{put :edit, params: {history: history.attributes}
			}.to raise_error(ActionController::UrlGenerationError)
		end
		it "does not allow destroy" do
			history.save
			expect{delete :destroy, params: {history: history.attributes}
			}.to raise_error(ActionController::UrlGenerationError)
		end
	end
	context "With moderator user" do
		before :each do
			session[:user_id] = FactoryGirl.create(:user_moderator)
		end
		it "allows create" do
			expect{post :create, params: {history: history.attributes}
			}.to change(History,:count).by(1)
		end
		it "does not allow edit" do
			history.save
			expect{put :edit, params: {history: history.attributes}
			}.to raise_error(ActionController::UrlGenerationError)
		end
		it "does not allow destroy" do
			history.save
			expect{delete :destroy, params: {history: history.attributes}
			}.to raise_error(ActionController::UrlGenerationError)
		end
	end
end
