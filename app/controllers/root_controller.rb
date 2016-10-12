class RootController < ApplicationController
  def index
    @link = Link.new
    @top_links = Link.most.popular
    @recent_links = Link.most.recent
    @top_users = User.top_users
  end
end
