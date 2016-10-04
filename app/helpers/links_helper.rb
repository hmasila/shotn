module LinksHelper
  def strip_time(time)
    Date.strptime(time.to_s, "%Y-%m-%d")
  end

  def root
    'localhost:3000/'
  end
end
