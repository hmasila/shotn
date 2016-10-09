class Link < ApplicationRecord
  require 'pismo'
  belongs_to :user, optional: true

  include ConstantsHelper

  scope :most_popular, lambda {
    where(deleted: false).order('clicks desc')
                         .limit(5).select('title', 'full_url',
                                          'vanity_string', 'clicks')
  }

  scope :most_recent, lambda {
    where(deleted: false).order('created_at desc')
                         .limit(5).select('title', 'full_url',
                                          'vanity_string', 'created_at')
  }
  validates :full_url, presence: true, url: true
  validates :vanity_string, presence: true, uniqueness: true,
                            length: { maximum: 6 }
  after_create :link_title

  def link_title
    self.title = Pismo::Document.new(full_url).title
    save
  end
end
