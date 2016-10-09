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
    subject(:user) { create(:user) }
    context 'with valid credentials' do
      before(:each) do
        post :create, params: { email: user.email, password: user.password }
      end

      it 'creates a user session' do
        expect(session[:user_id]).to eq user[:id]
      end

      it 'shows successfully logged in' do
        expect(flash[:success]).to eql(
          'Successfully logged in.'
        )
      end

      it 'returns a status code of 302' do
        expect(response.status).to eq 302
      end

      it 'redirects to home path' do
        expect(response).to redirect_to home_path
      end
    end

    context 'with invalid credentials' do
      before(:each) { post :create }

      let(:user) do
        create(:user)
        post :create, params: { user: attributes_for(:user, email: nil) }
      end
      it 'redirects to login path' do
        user
        expect(response).to redirect_to login_path
      end
      it 'raises an error' do
        expect(flash[:danger]).to eql(
          'Login failed. Email or password is incorrect!'
        )
      end
      it 'should not have a session' do
        expect(session[:id]).to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) { get :destroy }
    context 'when user logged in' do
      it 'destroys user session' do
        expect(session[:user_id]).to be_nil
      end

      it 'shows successfully logged out' do
        expect(flash[:success]).to eql(
          'Successfully logged out'
        )
      end

      it 'returns a status code of 302' do
        expect(response.status).to eq 302
      end

      it 'redirects to login path' do
        expect(response).to redirect_to root_path
      end
    end
  end
end
