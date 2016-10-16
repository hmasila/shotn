module LinksHelper
  def strip_time(time)
    Date.parse(time.to_s).strftime('%Y-%m-%d')
  end

  def time_ago(time)
    distance_of_time_in_words(time, Time.now) + ' ago'
  end

  def short_link(link)
    root_url + link.vanity_string
  end
end
