module LinksHelper
  def strip_time
    Date.strptime(time_created.to_s, "%Y-%m-%d")
  end
end
