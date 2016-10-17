require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe '#create' do
    context 'when link has valid parameters' do
      let(:vanity_string) { 'test' }

      subject(:link) { create(:link) }

      let(:message) { 'Link generated successfully.' }

      before do
        post :create, params: {
          link: attributes_for(:link, vanity_string: vanity_string)
        }
      end

      it 'should increase link count by 1' do
        expect { subject }.to change(Link, :count).by(1)
        expect(flash[:success]).to eq message
        expect(flash[:notice]).to eq root_url + vanity_string
      end

      it 'should return 302 status' do
        expect(response.status).to eq(302)
      end
    end

    context 'when user is logged in' do
      let(:user) { create :user }
      before do
        stub_current_user(user)
        post :create, params: {
          link: attributes_for(:link, vanity_string: 'test')
        }
      end

      it 'redirects to home path' do
        expect(response).to redirect_to home_path
      end
    end

    context 'when user is not logged in' do
      before do
        post :create, params: {
          link: attributes_for(:link, vanity_string: 'test')
        }
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'when link has invalid parameters' do
      before(:each) do
        post :create, params: {
          link: attributes_for(:link, full_url: nil)
        }
      end

      it 'should not increase link count by 1' do
        expect(assigns[:link].errors[:full_url]).to include "can't be blank"
        expect(flash[:danger]).to be_present
      end

      it 'should return 302 status' do
        expect(response.status).to eq(302)
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe '#index' do
    context 'when user is logged in' do
      let(:user) { create :user }

      before do
        stub_current_user(user)
        get :index
      end

      it 'assigns @links to current_user links' do
        expect(assigns(:links)).to eq user.links
      end

      it 'renders the index template' do
        expect(response).to render_template :index
      end

      it 'returns a 200 status' do
        expect(response.status).to eq 200
      end
    end
  end

  describe '#show' do
    let(:user) { create :user }

    let(:link) { create :link }

    before do
      stub_current_user(user)
      get :show, params: { id: link.id }
    end

    it 'renders show template' do
      expect(response).to render_template :show
    end

    it 'returns a 200 status' do
      expect(response.status).to eq 200
    end
  end

  describe '#edit' do
    let(:user) { create :user }

    let(:link) { create :link }

    before do
      stub_current_user(user)
      get :edit, params: { id: link.id }
    end

    it 'renders edit template' do
      expect(response).to render_template :edit
    end

    it 'returns a 200 status' do
      expect(response.status).to eq 200
    end
  end

  describe '#update' do
    let(:user) { create :user }

    let!(:link) { create(:link, vanity_string: 'update') }

    before do
      stub_current_user(user)
      put :update, params: { id: link.id, link: attributes_for(:link) }
    end

    it 'redirects to home path' do
      expect(response).to redirect_to home_path
    end

    it 'returns a 302 status' do
      expect(response.status).to eq 302
    end

    context 'when link parameters are valid' do
      it 'updates the link' do
        expect(flash[:success]).to eq 'Link updated successfully'
      end
    end

    context 'when link parameters are invalid' do
      it 'raises an error' do
        put :update, params: {
          id: link.id, link: attributes_for(:link, full_url: nil)
        }
        expect(assigns(:link).errors[:full_url]).to include "can't be blank"
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe '#original_url' do
    before do
      get :original_url, params: { vanity_string: link.vanity_string }
    end

    subject(:link) { create(:link) }

    it 'returns a 302 status' do
      expect(response.status).to eq 302
    end

    context 'when link is active and not deleted' do
      it 'redirects to full url' do
        expect(response).to redirect_to link.full_url
      end
    end

    context 'when link is inactive and deleted' do
      let(:link) { create(:link, deleted: true) }

      it 'redirects to error path' do
        expect(response).to redirect_to error_path
      end
    end
  end

  describe '#destroy' do
    let(:user) { create :user }

    let(:link) { create(:link) }

    before do
      stub_current_user(user)
      delete :destroy, params: { id: link.id }
    end

    it 'sets link to deleted' do
      expect(assigns(:link).deleted).to eql true
    end

    it 'redirects to home_path' do
      expect(response).to redirect_to home_path
    end

    it 'returns a 302 status' do
      expect(response.status).to eq 302
    end

    it 'sets a success flash' do
      expect(flash[:success]).to eq 'Link deleted successfully'
    end
  end

  describe 'error' do
    let(:link) { create(:link) }

    before(:each) do
      get :error, params: { vanity_string: link.vanity_string }
    end

    it 'renders plain layout' do
      expect(response).to render_template 'plain_layout'
    end

    it 'returns a 200 status' do
      expect(response.status).to eq 200
    end
  end
end
