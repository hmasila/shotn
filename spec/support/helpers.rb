module Helpers
  def login_as(user)
    authenticate(user.email, user.password)
    request.session[:user_id] = user.id
  end

  def authenticate(email, password)
    @user = User.find_by_email(email)
    @user.authenticate(password)
  end

  def log_in_with(email, password)
    visit login_path
    fill_in 'session[email]', with: email
    fill_in 'session_password', with: password
    click_button 'Login'
  end

  def stub_current_user(user)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
  end

  def stub_require_login
    allow_any_instance_of(ApplicationController)
      .to receive(:require_login).and_return(true)
  end
end
