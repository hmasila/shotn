class SessionsController < ApplicationController
  def new
    render layout: 'plain_layout'
    redirect_to home_path if current_user
    @user = User.new
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to home_path, notice: "Login successful"
    else
      flash[:error] = "Loggin failed!"
      redirect_to login_path, notice: "Loggin failed!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
