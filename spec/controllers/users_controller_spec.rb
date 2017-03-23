require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

	context "User not logged in" do

		describe "GET #index" do
			it "creates an array of correct users" do
		    user = FactoryGirl.create(:user)
			get :index
			expect(assigns(:users)).to eq([user])
			#Testi muutetaan tuotantoversioon
			end
		end


		describe "GET #show" do
			it "doesn't show user page" do
				user = FactoryGirl.create(:user)
				get :show, params: { id: user }
				expect(response).to redirect_to ideas_path
			end
		end


		describe "GET #new" do
			it "doesn't get new, if not admin" do
				get :new
				expect(response).to redirect_to ideas_path
			end
		end

		describe "GET #edit" do
			it "doesn't edit, if not admin" do
				user = FactoryGirl.create(:user)
				get :edit, params: { id: user }
				expect(response).to redirect_to ideas_path
			end
		end

		describe "POST #create" do
			it "doesn't create new, if not admin" do
				expect{
				post :create, params: { user: FactoryGirl.attributes_for(:user) }
				}.to_not change(User, :count)
				expect(response).to redirect_to ideas_path
			end
		end

		describe "PUT #update" do
			it "doesn't update name, if not admin" do
				@user = FactoryGirl.create(:user)
		        put :update, params: { id: @user, user: FactoryGirl.attributes_for(:user, name: "vaihdettu") }
		        @user.reload
			expect(@user.name).to eq("Testi Tauno")
			end
		end

		describe "DELETE #destroy" do
			it "don't destroy, if not admin" do
				user = FactoryGirl.create(:user)
		        expect{delete :destroy, params: { id: user }}.to_not change(User, :count)
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
			get :show, params: { id: user }
			expect(assigns(:user)).to eq(user)
			expect(response).to render_template :show
			end

		end

		describe "PUT #update" do
			it "update name" do
				@user = FactoryGirl.create(:user)
		        put :update, params: { id: @user, user: FactoryGirl.attributes_for(:user, name: "vaihdettu") }
		        @user.reload
		        expect(@user.name).to eq("vaihdettu")
			end
			it "updates title" do
				@user = FactoryGirl.create(:user)
				expect(@user.title).not_to eq("Puheenjohtaja")
				put :update, params: {id: @user, user: FactoryGirl.attributes_for(:user, title: "Puheenjohtaja")}
				@user.reload
				expect(@user.title).to eq("Puheenjohtaja")
			end
		end

		describe "POST #create" do
			it "create new if admin" do
				expect{
				post :create, params: { user: FactoryGirl.attributes_for(:user) }
				}.to change(User, :count).by(1)
			end
		end

		describe "DELETE #destroy" do
			it "destroy user" do
				user = FactoryGirl.create(:user)
		        expect{delete :destroy, params: { id: user }}.to change(User, :count).by(-1)
			end
		end
	end


	context "Basic user logged in" do
		before :each do
			current_user = FactoryGirl.create(:user_student)
		    session[:user_id] = current_user.id
		end

        #Otetaan tuotanto versiossa käyttöön
		# describe "GET #index" do
		# 	it "Doesn't let them access user list" do
		#     user = FactoryGirl.create(:user)
		# 	get :index
		# 	response.should redirect_to ideas_path
		# 	end
		# end


		describe "GET #show" do
			it "It returns user page" do
				user = FactoryGirl.create(:user)
				get :show, params: { id: user }
				expect(response).to render_template :show
			end
			end


		describe "GET #new" do
			it "doesn't get new, if not admin" do
				get :new
				expect(response).to redirect_to ideas_path
			end
		end

		describe "GET #edit" do
			it "doesn't edit, if not admin" do
				user = FactoryGirl.create(:user)
				get :edit, params: { id: user }
				expect(response).to redirect_to ideas_path
			end
		end

		describe "POST #create" do
			it "doesn't create new, if not admin" do
				expect{
				post :create, params: { user: FactoryGirl.attributes_for(:user) }
				}.to_not change(User, :count)
				expect(response).to redirect_to ideas_path
			end
		end

		describe "PUT #update" do
			it "doesn't update name" do
				@user = FactoryGirl.create(:user)
		        put :update, params: {id: @user, user: FactoryGirl.attributes_for(:user, name: "vaihdettu")}
		        @user.reload
			expect(@user.name).to eq("Testi Tauno")
			end
			it "doesn't update title" do
				@user = FactoryGirl.create(:user)
				expect(@user.title).not_to eq("Puheenjohtaja")
				put :update, params: {id: @user, user: FactoryGirl.attributes_for(:user, title: "Puheenjohtaja")}
				@user.reload
				expect(@user.title).not_to eq("Puheenjohtaja")
			end
		end

		describe "DELETE #destroy" do
			it "don't destroy, if not admin" do
				user = FactoryGirl.create(:user)
		        expect{delete :destroy, params: {id: user}}.to_not change(User, :count)
			end
		end
	end

	context 'User #show is viewed' do
		before :each do
			user = FactoryGirl.create(:user)
			session[:user_id] = user.id
			idea1 = FactoryGirl.create(:idea, topic: 'topic1')
			idea2 = FactoryGirl.create(:idea, topic: 'topic2')
			idea3 = FactoryGirl.create(:idea, topic: 'topic3')
			moderator = FactoryGirl.create(:user_moderator)
			session[:user_id] = moderator.id
			idea2.histories << FactoryGirl.create(:history, basket: 'Approved')
			idea3.histories << FactoryGirl.create(:history, basket: 'Rejected')
			session[:user_id] = user.id
			get :show, params: { id: user }

		end

		render_views

		describe 'by the user' do
			it 'and all ideas are shown' do
				expect(response).to render_template :show
				expect(response.body).to have_content('topic1')
				expect(response.body).to have_content('topic2')
				expect(response.body).to have_content('topic3')
			end
		end

		describe 'by other user' do
			it 'and New and Rejected ideas are not shown' do
				newUser = FactoryGirl.create(:user, persistent_id: 123456789, name: "esa")
				session[:user_id] = newUser.id
				get :show, params: { id: 1 }
				expect(response).to render_template :show
				expect(response.body).to have_content('topic2')
				expect(response.body).not_to have_content('topic1')
				expect(response.body).not_to have_content('topic3')
			end
		end

		describe 'by moderator' do
			it 'and all ideas are shown' do
				moderator = FactoryGirl.create(:user_moderator, persistent_id: 123456789)
				session[:user_id] = moderator.id
				get :show, params: { id: 1 }
				expect(response).to render_template :show
				expect(response.body).to have_content('topic1')
				expect(response.body).to have_content('topic2')
				expect(response.body).to have_content('topic3')
			end
		end

		describe 'by admin' do
			it 'and New and Rejected ideas are not shown' do
				admin = FactoryGirl.create(:user_admin, persistent_id: 123456789)
				session[:user_id] = admin.id
				get :show, params: { id: 1 }
				expect(response).to render_template :show
				expect(response.body).to have_content('topic2')
				expect(response.body).not_to have_content('topic1')
				expect(response.body).not_to have_content('topic3')
			end
		end
	end
end
