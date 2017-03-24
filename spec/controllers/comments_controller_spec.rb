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
				expect{post :create, params: { comment: comment.attributes }
				}.to change(Comment,:count).by(1)
			end
			it "is made with the logged in user" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = comment.user.id
				post :create, params: { comment: comment.attributes }
				expect(Comment.last.user).to eq(comment.user)
			end

			it "does not allow arbitrary user_id:s" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = comment.user.id
				a=comment.attributes
				a["user_id"]=5
				post :create, params: { comment: a }
				expect(Comment.last.user).to eq(comment.user)

			end

			it "has visibility false when idea is under moderation" do
				idea = FactoryGirl.create(:idea, moderate: true)
				comment= FactoryGirl.build(:comment, idea: idea)
				session[:user_id] = comment.user.id
				post :create, params: { comment: comment.attributes }
				expect(Comment.last.visible).to be_falsey

			end
			it "has visibility true when idea is not under moderation" do
				idea = FactoryGirl.create(:idea, moderate: false)
				comment= FactoryGirl.build(:comment, idea: idea)
				session[:user_id] = comment.user.id
				post :create, params: { comment: comment.attributes }
				expect(Comment.last.visible).to be_truthy
			end
		end
		describe "DELETE #destroy" do
			it "destroys comments when moderators requests" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = comment.user.id
				user = FactoryGirl.create(:user_moderator, persistent_id: 349872897324789)
				session[:user_id] = user.id
				comment = FactoryGirl.create(:comment, user: user)
				expect{delete :destroy, params: { id: comment.id }
				}.to change(Comment,:count).by(-1)

			end
			it "does not let normal users destroy comments" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = comment.user.id
				expect{delete :destroy, params: { id: comment.id }
				}.not_to change(Comment,:count)
			end
		end
		describe "PATCH #update" do
			it "does not let anyone modify comments" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = comment.user.id
				expect{put :update, params: { comment: comment.attributes }}.to raise_error(ActionController::UrlGenerationError)
			end
		end
		describe "POST #publish" do
			it "does not change" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = comment.user.id
				expect{post :publish, params: {id: comment.id}}.not_to change(comment, :visible)

			end
		end
		describe "POST #unpublish" do
			it "does not change" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = comment.user.id
				expect{post :unpublish, params: {id: comment.id}}.not_to change(comment, :visible)

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
				expect{post :create, params: { comment: comment.attributes }}.not_to change(Comment,:count)
			end

		end
		describe "DELETE #destroy" do
			it "does not let non logged users to destroy comments" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = nil
				delete :destroy, params: { id: comment.id }
				expect{post :create, params: { comment: comment.attributes }}.not_to change(Comment,:count)
			end
		end
		describe "PATCH #update" do
			it "does not let anyone modify comments" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = nil
				expect{put :update, params: { comment: comment.attributes }}.to raise_error(ActionController::UrlGenerationError)
			end
		end
		describe "POST #publish" do
			it "does not change" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = nil
				expect{post :publish, params: {id: comment.id}}.not_to change(comment, :visible)

			end
		end
		describe "POST #unpublish" do
			it "does not change" do
				comment= FactoryGirl.create(:comment)
				session[:user_id] = nil
				expect{post :unpublish, params: {id: comment.id}}.not_to change(comment, :visible)

			end
		end
	end
	context "With moderator logged in" do
		before :each do
		end
		describe "POST #publish" do
			it "changes to published" do
				session[:user_id] = FactoryGirl.create(:user_moderator).id
				comment= FactoryGirl.create(:comment)
				comment.visible=false
				comment.save
				expect{post :publish, params: {id: comment.id}}.to change{Comment.first.visible}

			end
		end
		describe "POST #unpublish" do
			it "changes to unpublished" do
				session[:user_id] = FactoryGirl.create(:user_moderator).id
				comment= FactoryGirl.create(:comment)
				expect{post :unpublish, params: {id: comment.id}}.to change{Comment.first.visible}
			end
		end
	end

end
