require 'rails_helper'

RSpec.describe TagsController, :type => :controller do

	context "User not logged in" do
		
		describe "GET #index" do
			it "redirect to ideas path, if not moderator" do
				tag = FactoryGirl.create(:tag)
				get :index
				expect(assigns(:tags)).to eq(nil)
				expect(response).to redirect_to ideas_path
			end
		end

		describe "GET #show" do
			it "redirect to ideas path, if not moderator" do
				tag = FactoryGirl.create(:tag)
				get :show, params: { id: tag }
				expect(assigns(:tags)).to eq(nil)
				expect(response).to redirect_to ideas_path
			end
		end

		describe "GET #new" do
			it "doesn't get new, if not moderator" do
				get :new
				expect(response).to redirect_to ideas_path
			end
		end

		describe "GET #edit" do
			it "doesn't edit, if not moderator" do
				tag = FactoryGirl.create(:tag)
				get :edit, params: { id: tag }
				expect(response).to redirect_to ideas_path
			end
		end

		describe "POST #create" do
			it "doesn't create new, if not moderator" do
				expect{
				post :create, params: { tag: FactoryGirl.attributes_for(:tag) }
				}.to_not change(Tag, :count)
				expect(response).to redirect_to ideas_path
			end
		end

		describe "PUT update" do
			it "doesn't update name, if not moderator" do
				@tag = FactoryGirl.create(:tag)		        
		        put :update, params: { id: @tag, tag: FactoryGirl.attributes_for(:tag, text: "vaihdettu") }	        
		        @tag.reload	        
			expect(@tag.text).to eq("tag text")
			end
		end

		describe "DELETE destroy" do
			it "don't destroy, if not admin" do
				tag = FactoryGirl.create(:tag)
		        expect{delete :destroy, params: { id: tag }}.to_not change(Tag, :count)
			end
		end
	end


	context "moderator logged in" do
		before :each do
			current_user = FactoryGirl.create(:user_moderator)
		    session[:user_id] = current_user.id
		end

		describe "GET #index" do
			it "populate array of tags" do
				tag = FactoryGirl.create(:tag)
				get :index
				expect(assigns(:tags)).to eq([tag])
				expect(response).to render_template :index
			end
		end

		describe "GET #show" do
			it "assigns the requested tag to @tag" do
		    tag = FactoryGirl.create(:tag)		    
			get :show, params: { id: tag }		
			expect(assigns(:tag)).to eq(tag)
			expect(response).to render_template :show		
			end
		end

		describe "PUT update" do
			it "update name" do
				@tag = FactoryGirl.create(:tag)		        
		        put :update, params: { id: @tag, tag: FactoryGirl.attributes_for(:tag, text: "vaihdettu") }	        
		        @tag.reload	        
			expect(@tag.text).to eq("vaihdettu")
			end
		end

		describe "POST #create" do
			it "create new tag, if moderator" do
				expect{
				post :create, params: { tag: FactoryGirl.attributes_for(:tag) }
				}.to change(Tag, :count).by(1)				
			end			
		end

		describe "DELETE destroy" do
			it "destroy tag" do
				tag = FactoryGirl.create(:tag)
		        expect{delete :destroy, params: { id: tag }}.to change(Tag, :count).by(-1)
			end
		end
	end

	context "Basic user logged in" do
		before :each do
			current_user = FactoryGirl.create(:user_student)
		    session[:user_id] = current_user.id
		end

		describe "GET #index" do
			it "redirect to ideas path, if not moderator" do
				tag = FactoryGirl.create(:tag)
				get :index
				expect(assigns(:tags)).to eq(nil)
				expect(response).to redirect_to ideas_path
			end
		end

		describe "GET #show" do
			it "redirect to ideas path, if not moderator" do
				tag = FactoryGirl.create(:tag)
				get :show, params: { id: tag }
				expect(assigns(:tags)).to eq(nil)
				expect(response).to redirect_to ideas_path
			end
		end

		describe "GET #new" do
			it "doesn't get new, if not moderator" do
				get :new
				expect(response).to redirect_to ideas_path
			end
		end

		describe "GET #edit" do
			it "doesn't edit, if not moderator" do
				tag = FactoryGirl.create(:tag)
				get :edit, params: { id: tag }
				expect(response).to redirect_to ideas_path
			end
		end

		describe "POST #create" do
			it "doesn't create new, if not moderator" do
				expect{
				post :create, params: { tag: FactoryGirl.attributes_for(:tag) }
				}.to_not change(Tag, :count)
				expect(response).to redirect_to ideas_path
			end
		end

		describe "PUT update" do
			it "doesn't update name, if not moderator" do
				@tag = FactoryGirl.create(:tag)		        
		        put :update, params: { id: @tag, tag: FactoryGirl.attributes_for(:tag, text: "vaihdettu") }	        
		        @tag.reload	        
			expect(@tag.text).to eq("tag text")
			end
		end

		describe "DELETE destroy" do
			it "don't destroy, if not admin" do
				tag = FactoryGirl.create(:tag)
		        expect{delete :destroy, params: { id: tag }}.to_not change(Tag, :count)
			end
		end
	end
end
