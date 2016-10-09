require 'rails_helper'

RSpec.describe 'users/new.html.erb', type: :feature do
  before(:all) do
    @name = Faker::Name.name
    @email = Faker::Internet.email
    @password = Faker::Internet.password(8)
  end

  scenario 'when user tries to sign up with valid data' do
    sign_up_with(@name, @email, @password, @password)
    expect(page.current_path).to eq '/home'
    expect(page).to have_content 'Registration successful'
  end

  scenario 'when user tries to sign up with an email that has been taken' do
    sign_up_with(@name, @email, @password, @password)
    Capybara.reset_sessions!
    visit signup_path
    sign_up_with(
      Faker::Name.name,
      @email, @password, @password
    )
    expect(page).to have_content 'Email has already been taken'
  end

  scenario 'user attempts to sign up with incomplete credentials' do
    visit signup_path
    fill_in 'user_name', with: @name
    fill_in 'user_email', with: @email
    click_button 'Sign up'
    expect(page.current_path).to eq '/signup'
    expect(page).to have_content "Password can't be blank"
  end

  scenario 'when user tries to sign up with names less than 2' do
    sign_up_with('a', Faker::Internet.free_email, @password, @password)
    expect(page.current_path).to eq '/signup'
    expect(page).to have_content 'Name too short'
  end

  scenario 'when user tries to sign up with password less than 5' do
    sign_up_with(@name, Faker::Internet.free_email, '012', '012')
    expect(page.current_path).to eq '/signup'
    expect(page).to have_content 'Password is too short'
  end
end
