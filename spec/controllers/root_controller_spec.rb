require 'rails_helper'

RSpec.describe RootController, type: :controller do
  describe 'GET #index' do
    before(:each) { get :index }
    it 'returns a status code of 200' do
      expect(response.status).to eq 200
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

    it 'assigns @link to a new link' do
      expect(assigns(:link)).to be_a_new Link
    end

    it 'assigns @top_users to the top 5 users' do
      expect(assigns(:top_users)).to eq User.top_users
    end

    it 'assigns @top_links to the top 5 links' do
      expect(assigns(:top_links)).to eq Link.most.popular
    end

    it 'assigns @recent_links to the 5 most recently created links' do
      expect(assigns(:recent_links)).to eq Link.most.recent
    end
  end
end
