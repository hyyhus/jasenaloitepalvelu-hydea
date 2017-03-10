require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

	context "With user logged in" do
		before :each do
		end
		describe "GET #index" do
			it "responds to get" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = comment.user.id
				get :index
				expect(response.status).to eq(200)

			end
		end
		describe "POST #create" do
			it "adds comments to ideas" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = comment.user.id
				expect{post :create, comment: comment.attributes
				}.to change(Comment,:count).by(1)
			end
			it "is made with the logged in user" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = comment.user.id
				post :create, comment: comment.attributes
				expect(Comment.last.user).to eq(comment.user)
			end

			it "does not allow arbitrary user_id:s" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = comment.user.id
				a=comment.attributes
				a["user_id"]=5
				post :create, comment: a
				expect(Comment.last.user).to eq(comment.user)

			end
		end
		describe "DELETE #destroy" do
			it "destroys comments when moderators requests" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = comment.user.id
				user = FactoryGirl.create(:user_moderator, persistent_id: 349872897324789)
				session[:user_id] = user.id
				comment = FactoryGirl.create(:comment, user: user)
				expect{delete :destroy, id: comment.id
				}.to change(Comment,:count).by(-1)

			end
			it "does not let normal users destroy comments" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = comment.user.id
				expect{delete :destroy, id: comment.id
				}.not_to change(Comment,:count)
			end
		end
		describe "PATCH #update" do
			it "does not let anyone modify comments" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = comment.user.id
				expect{put :update, comment: comment.attributes}.to raise_error(ActionController::UrlGenerationError)
			end
		end
	end
	context "With no user logged in" do
		before :each do
			session[:user_id] = nil
		end
		describe "GET #index" do
			it "responds to get" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = comment.user.id
				get :index
				expect(response.status).to eq(200)

			end
		end
		describe "POST #create" do
			it "does not add comments to ideas" do
				comment= FactoryGirl.build(:comment)
				session[:user_id] = nil
				expect{post :create, comment: comment.attributes}.not_to change(Comment,:count)
			end

		end
		describe "DELETE #destroy" do
			it "does not let non logged users to destroy comments" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = nil
				delete :destroy, id: comment.id
				expect{post :create, comment: comment.attributes}.not_to change(Comment,:count)
			end
		end
		describe "PATCH #update" do
			it "does not let anyone modify comments" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = nil
				expect{put :update, comment: comment.attributes}.to raise_error(ActionController::UrlGenerationError)
			end
		end
	end

end
