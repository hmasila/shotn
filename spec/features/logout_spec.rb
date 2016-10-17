require 'rails_helper'

RSpec.describe 'User Logout', type: :feature do
  let(:user) { create(:user) }

  before do
    sign_in_with(user.email, user.password)
    visit home_path
  end

  scenario 'when user logs out' do
    click_link 'Logout'
    expect(page.current_path).to eq root_path
  end
end
