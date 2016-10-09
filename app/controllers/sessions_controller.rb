class SessionsController < ApplicationController
  include ConstantsHelper
  layout 'plain_layout', only: [:new]

  def new
    redirect_to home_path if current_user
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      start_session
    else
      flash[:danger] = LOGIN_FAILED
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = LOGOUT_SUCCESS
    redirect_to root_path
  end

  private

  def start_session
    session[:user_id] = @user.id
    flash[:success] = LOGIN_SUCCESS
    redirect_to home_path
  end
end
