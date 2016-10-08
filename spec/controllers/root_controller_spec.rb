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

    it 'has valid instance variables' do
      expect(assigns(:link)).to be_a_new Link
      expect(assigns(:top_users)).to_not be_nil
      expect(assigns(:top_links)).to_not be_nil
      expect(assigns(:recent_links)).to_not be_nil
    end
  end
end
