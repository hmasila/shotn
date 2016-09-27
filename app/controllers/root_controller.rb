class RootController < ApplicationController
  def index
    @top_links = Link.most_popular
    @first_three_links = @top_links[0..2]
    @next_two_links = @top_links[3..5]
    @recent_links = Link.most_recent
    @top_users = User.top_users
  end
end
