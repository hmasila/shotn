class LinksController < ApplicationController
  before_action :login_required, only: [:edit, :update, :destroy]
  before_action :set_link, only: [:edit, :update, :destroy]

  def create
    @link = Link.new(link_params)
    return unless short_url_unique(@link.vanity_string)
    return if reserved_word?

    if @link.save
      url_save_success
    else
      url_save_failure
    end
  end

  private

end
