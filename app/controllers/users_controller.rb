class UsersController < ApplicationController
  before_action :require_login, only: [:home]
  before_action :get_current_user, only: [:home]

  def new
    @user = User.new
    render layout: 'auth'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      user_save_success
    else
      user_save_failure
    end
  end

  def home
    @links = @user.links
  end

  private

  def user_save_success
    session[:user_id] = @user.id
    flash[:success] = "Registration successful"
    redirect_to home_path
  end

  def user_save_failure
    flash[:error] = "Registration failed"
    redirect_to signup_path
  end

  def user_params
    params.require(:user)
          .permit(:email, :password, :name, :password_confirmation)
  end

  def get_current_user
    @user = current_user
  end
end
