class LinksController < ApplicationController
  before_action :require_login, only: [:edit, :update, :destroy, :index]
  before_action :set_link, only: [:edit, :show, :update, :destroy]
  before_action :find_by_vanity_string, only: [:original_url_path, :error]
  after_action :short_url, only: [:create]

  include ConstantsHelper

  def index
    @links = current_user.links
  end

  def create
    @link = Link.new(full_params)
    current_user_updates
    if @link.save
      successful_link_creation
    else
      flash[:danger] = @link.errors.full_messages.to_sentence
      redirect_to root_url
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
    if @link.update(full_params)
      flash[:success] = LINK_UPDATED
    else
      flash[:danger] = @link.errors.full_messages.to_sentence
    end
    redirect_to home_path
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

  def full_params
    params = link_params
    params[:user_id] = current_user.id if current_user
    params[:vanity_string] = SecureRandom.urlsafe_base64(4) if params[:vanity_string].blank?
    params[:vanity_string] = params[:vanity_string].tr(' ', '_')
    params
  end

  def current_user_updates
    return unless current_user
    current_user.link_count += 1
    current_user.save
  end

  def successful_link_creation
    if logged_in?
      flash[:success] = SUCCESSFUL_LINK
      redirect_to home_path
    else
      flash[:success] = SUCCESSFUL_LINK
      redirect_to root_url
    end
  end

  def short_url
    return unless @link.vanity_string
    flash[:notice] = root_url + @link.vanity_string
  end
end
