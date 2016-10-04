require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    before(:each) {  get :new }
    it 'returns http success' do
      expect(response.status).to eq 200
    end

    it 'renders new template' do
      expect(response).to render_template(:new)
    end

    it 'uses plain_layout' do
      expect(response).to render_template('layouts/plain_layout')
    end
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      let(:saved_user) { FactoryGirl.create(:user) }

      before(:each) do
        post :create, params: {
          saved_user: FactoryGirl.attributes_for(:user)
        }
      end

      it 'creates a user session' do
        user
        expect(session[:user_id]).to eq user[:id]
      end

      it 'returns a status code of 302' do
        expect(response.status).to eq 302
      end

      it 'redirects to home path' do
        user
        expect(response).to redirect_to home_path
      end
    end

    context 'with invalid credentials' do
      before(:each) { get :create }

      let :user do
        post :create, params: {
          user: FactoryGirl.attributes_for(:user, password: 'incorrect', id: 1)
        }
      end
      it 'redirects to login path' do
        user
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) { get :destroy }
    context 'when user logged in' do
      it 'destroys user session' do
        expect(session[:user_id]).to be_nil
      end

      it 'returns a status code of 302' do
        expect(response.status).to eq 302
      end

      it 'redirects to login path' do
        expect(response).to redirect_to login_path
      end
    end
  end
end
