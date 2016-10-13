require 'rails_helper'

RSpec.describe 'User Logout', type: :feature do
  let(:user) { create(:user) }

  before(:each) { sign_in_with(user.email, user.password) }

  scenario 'user logs in' do
    visit home_path
    expect(page).to have_content 'Logout'
  end

  scenario 'user logs out' do
    click_link 'Logout'
    expect(page.current_path).to eq root_path
  end
end
