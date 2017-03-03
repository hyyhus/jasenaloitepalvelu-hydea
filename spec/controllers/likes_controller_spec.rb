require 'rails_helper'

RSpec.describe LikesController, type: :controller do
	let(:like){FactoryGirl.create(:like)}
	context "With user logged in" do
		before :each do
			session[:user_id] = like.user.id
		end

		describe "POST #create" do
			context "with valid attributes" do
				it "saves and attaches like to idea" do
					post :create, like: like.attributes
					expect(response.status).to eq(200)
				end
				it "redirects to the ideas page"
			end

			context "with invalid attributes" do
				it "does not save the new like in the database"
				it "re-renders the :new template"
			end
		end
		describe "DESTROY #delete" do
			context "with owned like" do
				it "destroys the like from database"
			end
			context "with someone elses idea" do
				it "does not destroy likes"
			end
		end
	end
	context "With no user logged in" do
		describe "POST #create" do
			context "with valid attributes" do
				it "does not save and attach like to idea"
				it "redirects to the ideas page"
			end

			context "with invalid attributes" do
				it "does not save the new like in the database"
				it "re-renders the :new template"
			end
		end
		describe "DESTROY #delete" do
			context "with someone elses idea" do
				it "does not destroy likes"
			end
		end
	end
end
