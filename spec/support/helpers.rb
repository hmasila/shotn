module Helpers
  def login_as(user)
    authenticate(user.email, user.password)
    request.session[:user_id] = user.id
  end

  def authenticate(email, password)
    @user = User.find_by_email(email)
    @user.authenticate(password)
  end

  def sign_in_with(email, password)
    visit login_path
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'Log In'
  end

  def sign_up_with(name, email, password, password_confirmation)
    visit root_path
    click_link 'Signup'
    fill_in 'user_name', with: name
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password_confirmation
    click_button 'Sign up'
  end

  def shorten_link
    full_url = 'https://google.com/'
    fill_in 'link_full_url', with: full_url
    click_button 'Shorten'
  end

  def stub_current_user(user)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
  end

  def create_link
    visit home_path
    @full_url = 'https://google.com/'
    @vanity = Faker::Internet.password(2, 6)
    fill_in 'link_full_url', with: @full_url
    fill_in 'link_vanity_string', with: @vanity
    click_button 'Shorten'
  end

  def find_link_id
    @link = Link.find_by_vanity_string(@vanity)
  end
end
