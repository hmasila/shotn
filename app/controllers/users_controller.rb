class UsersController < ApplicationController
  before_action :require_login, only: [:home]
  before_action :new_link, only: [:home]

  def new
    @user = User.new
    render layout: 'auth'
  end

  def create
    @user = User.create(user_params)
    if @user.save
      user_save_success
    else
      user_save_failure
    end
  end

  private

  def user_save_success
    login params[:user][:email], params[:user][:password]
    flash[:success] = "Welcome, #{@user.name.capitalize}"
    redirect_to home_path
  end

  def user_save_failure
    flash[:error] = "Registration failed"
    redirect_to signup_path
  end

  def home
    @links = @user.get_links.decorate
    render 'root/index'
  end

  def user_params
    params.require(:user)
          .permit :email, :password, :name
  end
end
