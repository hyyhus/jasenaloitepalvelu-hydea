require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_admin) { FactoryGirl.create(:user_admin) }
  let(:user_moderator) { FactoryGirl.create(:user_moderator) }

  it 'can be published by moderator' do
    session[:user_id] = user_moderator.id
    idea = FactoryGirl.create(:idea)
    expect { post :publish, id: idea.id }.to change(idea.histories, :count).by(1)
    expect(response).to redirect_to ideas_path
    expect(flash[:notice]).to eq('Idea was successfully published.')
  end

  # TODO
  it 'cannot be published by non-moderator' do
    session[:user_id] = user.id
    idea = FactoryGirl.create(:idea)
    expect { post :publish, id: idea.id }.not_to change(idea.histories, :count)
    expect(response).to redirect_to ideas_path
    expect(flash[:notice]).not_to eq('Idea was successfully published.')
  end

  it 'cannot be updated if not signed it or whatnot wrong test' do
    idea = FactoryGirl.create(:idea)
  end
end
