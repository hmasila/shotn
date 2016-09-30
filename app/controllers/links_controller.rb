class LinksController < ApplicationController
  before_action :require_login, only: [:edit, :update, :destroy]
  before_action :set_link, only: [:edit, :show, :update, :destroy]

  include ConstantsHelper

  def create
    @link = Link.new(link_params)
    set_user_id
    binding.pry
    return unless unique_vanity_string
    if @link.save
      successful_link_creation
    else
      flash[:error] = UNSUCCESSFUL_LINK
      redirect_to '/'
    end
  end

  def show
    if redirect_to @link.original_url
      @link.clicks += 1
      @link.save
    end
  end

  def edit
  end

  def update
    return unless unique_vanity_string
    if @link.update(link_params)
      flash[:success] = LINK_UPDATED
    else
      flash[:error] = LINK_NOT_UPDATED
    end
  end

  def unique_vanity_string
    Link.find_by(vanity_string: params[:vanity_string])
  end

  def successful_link_creation
    if logged_in?
      flash[:success] = SUCCESSFUL_LINK
      redirect_to home_path
    end
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:full_url, :vanity_string, :active)
  end

  def set_user_id
    @link.user_id = current_user.id
  end

end
