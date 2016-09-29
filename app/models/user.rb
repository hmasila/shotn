class User < ApplicationRecord
  has_many :links

  before_save :encrypt_password
  after_save :clear_password
  attr_accessor :password

  VALID_EMAIL = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  scope :top_users, lambda {
    order('links.count desc').limit(5).select('name', 'links.count')
  }

  validates :name, length: {
    minimum: 2,
    message: 'too short. Minimum length is two characters'
  }

  validates :password, length: {
    minimum: 5,
    message: 'too short. Minimum length is five characters'
  }, confirmation: true, on: :create

  validates :email,
            presence: true,
            length: { maximum: 255 },
            uniqueness: true,
            format: { with: VALID_EMAIL,
                      message: 'Please use a valid email' }

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password_digest = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end

  def self.authenticate(email, password)
    @user = User.where(email: email).first
    if @user && @user.password_digest == BCrypt::Engine.hash_secret(password, @user.salt)
      @user
    end
  end
end
