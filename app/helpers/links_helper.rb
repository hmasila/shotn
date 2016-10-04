module LinksHelper
  def strip_time(time)
    Date.strptime(time.to_s, '%Y-%m-%d')
  end

  def time_ago(time)
    distance_of_time_in_words(time, Time.now) + ' ago'
  end
end
