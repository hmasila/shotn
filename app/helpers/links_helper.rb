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

  def sort_links(links)
    links.sort_by do |link|
      link[:created_at]
    end.reverse!
  end

  def vanity
    SecureRandom.urlsafe_base64(4)
  end
end
