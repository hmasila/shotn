class Link < ApplicationRecord
  belongs_to :user, optional: true

  scope :most_popular, lambda {
    where(deleted: false).order('clicks desc')
                         .limit(5).select('full_url',
                                          'vanity_string', 'clicks')
  }

  scope :most_recent, lambda {
    where(deleted: false).order('created_at desc')
                         .limit(5).select('full_url',
                                          'vanity_string', 'created_at')
  }
  validates :full_url, presence: true
  before_create :gen_short_url

  def gen_short_url
    if self.vanity_string.nil? || self.vanity_string.eql?('')
      self.vanity_string = self.id.to_s(36)
    end
  end
end
