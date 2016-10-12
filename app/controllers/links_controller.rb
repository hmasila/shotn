class LinksController < ApplicationController
  before_action :require_login, only: [:edit, :update, :destroy, :index, :show]
  before_action :set_link, only: [:edit, :show, :update, :destroy]
  after_action :short_url, only: [:create]
  layout 'plain_layout', only: [:error]

  def index
    @links = Link.links(current_user)
  end

  def create
    @link = Link.new(full_params)
    update_user_link_count
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
  end

  def update
    if @link.update(full_params)
      flash[:success] = link_updated
    else
      flash[:danger] = @link.errors.full_messages.to_sentence
    end
    redirect_to home_path
  end

  def destroy
    @link.update(deleted: true)
    flash[:success] = delete_sucess
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
    params[:vanity_string] = Link.vanity if params[:vanity_string].blank?
    params[:vanity_string] = params[:vanity_string].gsub(/[^\w]/, '_')
    params
  end

  def successful_link_creation
    flash[:success] = successful_link
    if current_user
      redirect_to home_path
    else
      redirect_to root_url
    end
  end
end
