require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
	let(:comment){FactoryGirl.create(:comment)}
	before :each do
		session[:user_id] = comment.user.id
	end
	describe "GET #index" do
		it "responds to get" do
			get :index
			expect(response.status).to eq(200)

		end
	end
	describe "POST #create" do
		it "adds comments to ideas" do
			expect{post :create, comment: comment.attributes
			}.to change(Comment,:count).by(1)
		end
		it "is made with the logged in user" do
		post :create, comment: comment.attributes
		expect(Comment.last.user).to eq(comment.user)
		end

		it "does not allow arbitrary user_id:s" do
			a=comment.attributes
			a["user_id"]=5
		post :create, comment: a
		expect(Comment.last.user).to eq(comment.user)
			
		end
	end
	describe "DELETE #destroy" do
		it "destroys comments when moderators requests" do
			user = FactoryGirl.create(:user_moderator)
			session[:user_id] = user.id
			expect{delete :destroy, id: comment.id
			}.to change(Comment,:count).by(-1)

		end
		it "does not let normal users destroy comments" do
			expect{delete :destroy, id: comment.id
			}.not_to change(Comment,:count)
		end
	end
	describe "PATCH #update" do
		it "does not let anyone modify comments" do
			expect{put :update, comment: comment.attributes}.to raise_error(ActionController::UrlGenerationError)
		end
	end

end
