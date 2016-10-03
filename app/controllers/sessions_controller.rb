class SessionsController < ApplicationController
  include ConstantsHelper

  def new
    render layout: 'plain_layout'
    redirect_to home_path if current_user
    @user = User.new
  end

  def create
    @user = authenticate(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:success] = LOGIN_SUCCESS
      redirect_to home_path
    else
      flash[:error] = LOGIN_FAILED
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = LOGOUT_SUCCESS
    redirect_to login_path
  end

  private

  def authenticate(email, password)
    @user = User.where(email: email).first
    if @user && @user.password_digest == BCrypt::Engine.hash_secret(password,
                                                                    @user.salt)
      @user
    end
  end
end
