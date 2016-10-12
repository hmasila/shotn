class Link < ApplicationRecord
  require 'pismo'
  belongs_to :user, optional: true

  scope :most, (lambda do
                  where(deleted: false).limit(5).select('title', 'full_url',
                                                        'vanity_string', 'clicks',
                                                        'created_at')
                end)
  scope :popular, -> { order('clicks desc') }
  scope :recent, -> { order('created_at desc') }

  validates :full_url, presence: true, url: true
  validates :vanity_string, presence: true, uniqueness: true,
                            length: { maximum: 6 }
  after_create :link_title

  def link_title
    self.title = Pismo::Document.new(full_url).title
    save
  end
end
