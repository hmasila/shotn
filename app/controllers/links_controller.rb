class LinksController < ApplicationController
  before_action :require_login, only: [:edit, :update, :destroy]
  before_action :set_link, only: [:edit, :show, :update,
                                  :destroy]
  before_action :find_by_vanity_string, only: [:original_url_path, :error]

  include ConstantsHelper

  def index
    @links = current_user.links
  end

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
  end

  def edit
  end

  def error
    render layout: 'plain_layout'
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

  def destroy
    @link.update(deleted: true)
    flash[:success] = DELETE_SUCCESS
    redirect_to home_path
  end

  def original_url
    find_by_vanity_string
    if @link.active && !@link.deleted
      redirect_to_original
    else
      flash[:error] = INACTIVE_LINK
      redirect_to error_path
    end
  end

  private

  def redirect_to_original
    return unless redirect_to @link.full_url
    @link.clicks += 1
    @link.save
  end

  def find_by_vanity_string
    @link = Link.find_by(vanity_string: params[:vanity_string])
  end

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:full_url, :vanity_string, :active)
  end

  def set_user_id
    @link.user_id = current_user.id if logged_in?
  end

  def successful_link_creation
    if logged_in?
      flash[:success] = SUCCESSFUL_LINK
      redirect_to home_path
    else
      redirect_to '/'
    end
  end
end
