require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:user_valid_request) do
        post :create, params: {
          user: FactoryGirl.attributes_for(:user, id: 1)
        }
      end

      it 'creates a new User' do
        expect do
          user_valid_request
        end.to change(User, :count).by(1)
      end

      it 'redirects to home_path' do
        user_valid_request
        expect(response).to redirect_to home_path
      end
    end

    context 'with invalid attributes' do
      let(:user_invalid_request) do
        post :create, params: {
          user: FactoryGirl.attributes_for(:user, name: nil)
        }
      end

      it 'does not create a new User' do
        expect do
          user_invalid_request
        end.to change(User, :count).by(0)
      end

      it 'redirects to signup_path' do
        user_invalid_request
        expect(response).to redirect_to signup_path
      end
    end
  end
end
