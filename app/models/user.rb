class User < ApplicationRecord
  has_many :links

  before_save :encrypt_password, :lowercase_email
  attr_accessor :password

  VALID_NAME = /\A[^\d]+\z/
  VALID_EMAIL = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :name,
            presence: true,
            format: { with: VALID_NAME },
            length: { minimum: 2,
                      message: 'too short. Minimum length is two characters' }

  validates :password, length: {
    minimum: 5,
    message: 'too short. Minimum length is five characters'
  }, confirmation: true, on: :create

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: VALID_EMAIL,
                      message: 'Please use a valid email' }

  scope :top_users, lambda {
    joins('INNER JOIN links ON links.user_id=users.id')
      .select('users.name, COUNT(user_id) AS number')
      .group('users.name')
      .order('number DESC')
      .limit 5
  }
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password_digest = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def lowercase_email
    self.email = email.downcase
  end
end
