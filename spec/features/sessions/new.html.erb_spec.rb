require 'rails_helper'

RSpec.describe 'sessions/new.html.erb', type: :feature do
  before(:all) do
    @user = create(:user)
    @email = @user.email
    @password = @user.password
  end

  scenario 'when user tries to sign in with valid data' do
    sign_in_with(@email, @password)
    expect(page.current_path).to eq '/home'
    expect(page).to have_content 'Successfully logged in.'
  end

  scenario 'when user tries to sign in with incomplete credentials' do
    sign_in_with(@email, '')
    expect(page.current_path).to eq '/login'
    expect(page).to have_content 'Login failed'
  end

  scenario 'when user tries to sign in with invalid credentials' do
    sign_in_with(Faker::Internet.free_email, @password)
    expect(page.current_path).to eq '/login'
    expect(page).to have_content 'Login failed'
  end
end
