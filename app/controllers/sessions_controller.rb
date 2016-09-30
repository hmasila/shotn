class SessionsController < ApplicationController
  def new
    render layout: 'auth'
    @user = User.new
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to '/home', notice: "Login successful"
    else
      flash[:error] = "Loggin failed!"
      redirect_to '/login', notice: "Loggin failed!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
