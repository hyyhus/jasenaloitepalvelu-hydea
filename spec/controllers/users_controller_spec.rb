require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

	context "User not logged in" do

		describe "GET #index" do
			it "creates an array of correct users" do
		    user = FactoryGirl.create(:user)
			get :index
			assigns(:users).should eq([user])
			#Testi muutetaan tuotantoversioon
			end
		end


		describe "GET #show" do
			it "redirect to ideas path, if not admin" do
		    user = FactoryGirl.create(:user)	    
			get :show, id: user
			response.should redirect_to ideas_path
			end			
		end


		describe "GET #new" do
			it "doesn't get new, if not admin" do
				get :new
				response.should redirect_to ideas_path
			end
		end

		describe "GET #edit" do
			it "doesn't edit, if not admin" do
				user = FactoryGirl.create(:user)
				get :edit, id: user
				response.should redirect_to ideas_path
			end
		end

		describe "POST #create" do
			it "doesn't create new, if not admin" do
				expect{
				post :create, user: FactoryGirl.attributes_for(:user)
				}.to_not change(User, :count)
				response.should redirect_to ideas_path
			end
		end


	end


	context "Admin user logged in" do
		before :each do
			current_user = FactoryGirl.create(:user_admin)
		    session[:user_id] = current_user.id
		end

		describe "GET #show" do
			it "assigns the requested user to @user" do
		    user = FactoryGirl.create(:user)		    
			get :show, id: user		
			assigns(:user).should eq(user)
			response.should render_template :show		
			end

			it "assigns the requested user to @user" do
		    user = FactoryGirl.create(:user)		    
			get :show, id: user		
			assigns(:user).should eq(user)
			response.should render_template :show		
			end
		end




		describe "PUT update" do
			it "update name" do
				@user = FactoryGirl.create(:user)		        
		        put :update, id: @user, user: FactoryGirl.attributes_for(:user, name: "vaihdettu")	        
		        @user.reload	        
		        @user.name.should eq("vaihdettu")
			end
		end
	end
end


