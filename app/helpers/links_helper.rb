module LinksHelper
  def recent_links(time_created)
    Date.strptime(time_created.to_s, "%Y-%m-%d")
  end
end
