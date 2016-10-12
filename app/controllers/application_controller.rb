class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :require_login

  include Messages

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless current_user
      flash[:danger] = login_required
      redirect_to login_path
    end
  end

  def update_user_link_count
    return unless current_user
    current_user.update_attribute(:link_count, current_user.link_count += 1)
  end
end
