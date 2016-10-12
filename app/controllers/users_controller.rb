class UsersController < ApplicationController
  before_action :require_login, only: [:home]
  layout 'plain_layout', only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      user_save_success
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      redirect_to signup_path
    end
  end

  private

  def user_save_success
    session[:user_id] = @user.id
    flash[:success] = signup_success
    redirect_to home_path
  end

  def user_params
    params.require(:user)
          .permit(:email, :password, :name, :password_confirmation)
  end
end
