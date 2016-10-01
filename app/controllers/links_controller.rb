class LinksController < ApplicationController
  before_action :require_login, only: [:edit, :update, :destroy]
  before_action :set_link, only: [:edit, :show, :update, :destroy]

  include ConstantsHelper

  def create
    @link = Link.new(link_params)
    set_user_id
    if @link.save
      successful_link_creation
    else
      flash[:error] = UNSUCCESSFUL_LINK
    end
  end

  def show
    if @link.active
      if redirect_to @link.full_url
        @link.clicks += 1
        @link.save
      end
    else
      flash[:error] = INACTIVE_LINK
      redirect_to home_path
    end
  end

  def edit
  end

  def update
    if @link.update(link_params)
      redirect_to home_path
      flash[:success] = LINK_UPDATED
    else
      redirect_to home_path
      flash[:error] = LINK_NOT_UPDATED
    end
  end

  def successful_link_creation
    if logged_in?
      flash[:success] = SUCCESSFUL_LINK
      redirect_to home_path
    else
      redirect_to '/'
    end
  end

  def destroy
    @link.destroy
    redirect_to home_path
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:full_url, :vanity_string, :active)
  end

  def set_user_id
    if logged_in?
      @link.user_id = current_user.id
    end
  end

end
