require 'rails_helper'

RSpec.describe LikesController, type: :controller do
	let(:like){FactoryGirl.build(:like)}
	context "With user logged in" do
		before :each do
			session[:user_id] = like.user.id
		end

		describe "POST #create" do
			context "with valid attributes" do
				it "saves and attaches like to idea" do
					expect{post :create, params: { like: like.attributes }
					}.to change(Like,:count).by(1)
				end
				it "redirects to the ideas page" do
					post :create, params: { like: like.attributes }
					expect(response).to redirect_to ideas_path
				end
			end

			context "with invalid attributes" do
				it "does not save the new like in the database" do
				like.like_type="dislike"
					expect{post :create, params: { like: like.attributes }
					}.to_not change(Like,:count)
				end
				it "re-renders the :new template" do
				like.like_type="dislike"
					post :create, params: { like: like.attributes }
					expect(response).to redirect_to ideas_path
				end
			end
		end
		describe "DESTROY #delete" do
			context "with owned like" do
				it "destroys the like from database" do
					like.save
					expect{delete :destroy, params: { like: like.attributes, id: like.id }
					}.to change(Like,:count).by(-1)
				end
			end
			context "with someone elses idea" do
				it "does not destroy likes" do
					like.save
					session[:user_id] = FactoryGirl.create(:user, persistent_id:67326789324).id
					expect{delete :destroy, params: { like: like.attributes, id: like.id }
					}.not_to change(Like,:count)
				end
			end
		end
	end
	context "With no user logged in" do
		describe "POST #create" do
			context "with valid attributes" do
				it "does not save and attach like to idea" do
					expect{post :create, params: { like: like.attributes }
					}.not_to change(Like,:count)
				end
			end

			context "with invalid attributes" do
				it "does not save the new like in the database" do
				like.like_type="dislike"
					expect{post :create, params: { like: like.attributes }
					}.not_to change(Like,:count)
				end
				it "re-renders the :new template" do
				like.like_type="dislike"
					post :create, params: { like: like.attributes }
					expect(response).to redirect_to ideas_path
				end
			end
		end
	end
end
