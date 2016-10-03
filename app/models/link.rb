class Link < ApplicationRecord
  belongs_to :user, optional: true

  include ConstantsHelper

  scope :most_popular, lambda {
    where(deleted: false).order('clicks desc')
                         .limit(5).select('id', 'full_url',
                                          'vanity_string', 'clicks')
  }

  scope :most_recent, lambda {
    where(deleted: false).order('created_at desc')
                         .limit(5).select('id', 'full_url',
                                          'vanity_string', 'created_at')
  }
  validates :full_url, presence: true
  validates :vanity_string, uniqueness: true
  after_create :vanity_generate

  def vanity_generate
    generate_vanity_algorithm if vanity_string.nil? || vanity_string.eql?('')
  end

  def generate_vanity_algorithm
    id = self.id
    short_link = ''
    while id > 0
      short_link = CHARSET[id % BASE].chr + short_link
      id /= BASE
    end
    self.vanity_string = short_link.length > CODE_LENGTH ? '' : '0' *
      (CODE_LENGTH - short_link.length) + short_link
    save
  end
end
