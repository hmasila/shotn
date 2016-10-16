class User < ApplicationRecord
  has_many :links
  has_secure_password

  VALID_NAME = /\A[^\d]+\z/
  VALID_EMAIL = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :name,
            presence: true,
            format: { with: VALID_NAME },
            length: { minimum: 2 }
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: VALID_EMAIL }

  validates :password, length: {
    minimum: 5,
    confirmation: true
  }

  scope :top_users, (lambda do
    order('link_count DESC')
      .limit(5).select('name', 'created_at', 'link_count')
  end )
end
