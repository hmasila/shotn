require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe '#create' do
    context 'with valid parameters' do
      it 'should succeed and redirect back' do
        expect do
          post :create, params: {
            link: attributes_for(:link, full_url: 'https://google.com')
          }
        end.to change(Link, :count).by 1
        expect(flash[:success]).to be_present
        expect(flash[:notice]).to be_present
        expect(response.status).to eq(302)
      end
    end
  end
end
