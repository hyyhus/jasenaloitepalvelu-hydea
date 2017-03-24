require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_admin) { FactoryGirl.create(:user_admin) }
  let(:user_moderator) { FactoryGirl.create(:user_moderator) }
  let(:user_student) { FactoryGirl.create(:user_student, id: 2) }
  let(:user_student_with_history) { FactoryGirl.create(:user_student_with_history) }

  it 'can be published by moderator' do
    session[:user_id] = user_moderator.id
    @idea = FactoryGirl.create(:idea)
    expect { post :publish, params: { id: @idea.id } }.to change(@idea.histories, :count).by(1)
    expect(response).to redirect_to ideas_path
  end

  it 'cannot be published by non-moderator' do
    session[:user_id] = user.id
    @idea = FactoryGirl.create(:idea)
    expect { post :publish, params: { id: @idea.id } }.not_to change(@idea.histories, :count)
    expect(response).to redirect_to ideas_path
  end

  it 'topic is updated by moderator' do
    session[:user_id] = user_moderator.id
    @idea = FactoryGirl.create(:idea, topic: 'test topic to be updated')
    put :update, params: { id: @idea.id, idea: FactoryGirl.attributes_for(:idea, topic: 'updated topic') }
    @idea.reload
    expect(@idea.topic).to eq('updated topic')
    expect redirect_to @idea
  end

  it 'cannot be updated if not moderator' do
    session[:user_id] = user.id
    @idea = FactoryGirl.create(:idea, topic: 'test topic shall not update')
    put :update, params: { id: @idea.id, idea: FactoryGirl.attributes_for(:idea, topic: 'updated topic') }
    @idea.reload
    expect(@idea.topic).to eq('test topic shall not update')
    expect redirect_to ideas_path
  end

  it 'cannot be updated if not signed in' do
    session[:user_id] = user.id
    @idea = FactoryGirl.create(:idea, topic: 'test topic')
    session[:user_id] = nil
    put :update, params: { id: @idea.id, idea: FactoryGirl.attributes_for(:idea, topic: 'updated topic') }
    @idea.reload
    expect(@idea.topic).to eq('test topic')
    expect redirect_to ideas_path
  end

  describe "publish and moderate" do
    it "publishes idea with correct moerate valuee" do
      session[:user_id] = user_moderator.id
      @idea = FactoryGirl.create(:idea)
      expect { post :publish_moderate, params: { id: @idea.id } }.to change(@idea.histories, :count).by(1)
      @idea.reload
      expect(response).to redirect_to @idea
      expect(@idea.moderate).to be true
    end
  end

 describe "edit idea and enable moderate" do
    it "enables idea moderation" do
      session[:user_id] = user_moderator.id
      @idea = FactoryGirl.create(:idea)
      post :moderate, params: { id: @idea.id }
      @idea.reload
      expect(response).to redirect_to @idea
      expect(@idea.moderate).to be true
    end
  end

 describe "edit idea and disable moderate" do
    it "disables idea moderation" do
      session[:user_id] = user_moderator.id
      @idea = FactoryGirl.create(:idea)
      post :un_moderate, params: { id: @idea.id }
      @idea.reload
      expect(response).to redirect_to @idea
      expect(@idea.moderate).to be false
    end
  end

 describe "POST #create" do
    it "creates new if logged in and check that moderate value is correct" do
      session[:user_id] = user.id
      expect{
        post :create, params: { idea: FactoryGirl.attributes_for(:idea) }
        }.to change(Idea, :count).by(1)
      expect(Idea.first.moderate).to be false
    end
  end

  context "User not logged in" do


  describe "GET #show" do
    it "get idea from new -> not ok" do
      session[:user_id] = nil
      @idea = FactoryGirl.create(:idea)
      get :show, params: { id: @idea }
      expect(response).to redirect_to '/ideas?basket=Approved'
    end

    it "get idea from rejected -> not ok" do
      session[:user_id] = nil
      @idea = FactoryGirl.create(:idea_rejected)
      get :show, params: { id: @idea }
      expect(response).to redirect_to '/ideas?basket=Approved'
    end

    it "get idea from approved -> ok" do
      session[:user_id] = nil
      idea = FactoryGirl.create(:idea_approved)
      get :show, params: { id: idea.id }
      expect(assigns(:idea)).to eq(idea)
      expect(response).to render_template(:show)
    end
  end

  end


    context "Basic user logged in" do


  describe "GET #show" do
    it "get idea from new -> not ok" do
      session[:user_id] = user_student.id
      @idea = FactoryGirl.create(:idea)
      get :show, params: { id: @idea }
      expect(response).to redirect_to '/ideas?basket=Approved'
    end
    
    it "get own idea from new -> ok" do
      session[:user_id] = user_student_with_history.id
      idea = FactoryGirl.create(:idea_student)
      idea_history = FactoryGirl.create(:history_student, idea_id: idea.id, user_id: user_student_with_history.id)
      idea.histories << idea_history
      idea.histories.first.delete
      get :show, params: { id: idea.id }
      expect(assigns(:idea)).to eq(idea)
      expect(response).to render_template(:show)
    end

    it "get own idea from rejected -> not ok" do
      session[:user_id] = user_student_with_history.id
      idea = FactoryGirl.create(:idea_student)
      idea_history = FactoryGirl.create(:history_student, basket: "Rejected", idea_id: idea.id, user_id: user_student_with_history.id)
      idea.histories << idea_history
      idea.histories.first.delete
      get :show, params: { id: idea.id }
      expect(response).to redirect_to '/ideas?basket=Approved'
    end

    it "get idea from rejected -> not ok" do
      session[:user_id] = user_student.id
      @idea = FactoryGirl.create(:idea_rejected)
      get :show, params: { id: @idea }
      expect(response).to redirect_to '/ideas?basket=Approved'
    end

    it "get idea from approved -> ok" do
      session[:user_id] = user_student.id
      idea = FactoryGirl.create(:idea_approved)
      get :show, params: { id: idea.id }
      expect(assigns(:idea)).to eq(idea)
      expect(response).to render_template(:show)
    end
  end

  end


    context "Moderator user logged in" do


  describe "GET #show" do
    it "get idea from new -> ok" do
      session[:user_id] = user_moderator.id
      idea = FactoryGirl.create(:idea)
      get :show, params: { id: idea.id }
      expect(assigns(:idea)).to eq(idea)
      expect(response).to render_template(:show)
    end

    it "get idea from rejected -> ok" do
      session[:user_id] = user_moderator.id
      idea = FactoryGirl.create(:idea_rejected)
      get :show, params: { id: idea.id }
      expect(assigns(:idea)).to eq(idea)
      expect(response).to render_template(:show)
    end

    it "get idea from approved -> ok" do
      session[:user_id] = user_moderator.id
      idea = FactoryGirl.create(:idea_approved)
      get :show, params: { id: idea.id }
      expect(assigns(:idea)).to eq(idea)
      expect(response).to render_template(:show)
    end
  end

  end



end
