class UsersController < ApplicationController
  before_action :require_login, only: [:home]

  include ConstantsHelper

  def new
    @user = User.new
    render layout: 'plain_layout'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      user_save_success
    else
      flash[:danger] = SIGNUP_FAILURE
      redirect_to signup_path
    end
  end

  private

  def user_save_success
    session[:user_id] = @user.id
    flash[:success] = SIGNUP_SUCCESS
    redirect_to home_path
  end

  def user_params
    params.require(:user)
          .permit(:email, :password, :name, :password_confirmation)
  end
end
