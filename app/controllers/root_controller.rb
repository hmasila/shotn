class RootController < ApplicationController
  def index
    @link = Link.new
    @top_links = Link.most_popular
    @recent_links = Link.most_recent
    @top_users = User.top_users
  end
end
