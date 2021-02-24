class User < ApplicationRecord
  validates :email, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, on: :create
  before_validation :ensure_session_token, :ensure_activation_token

  has_many :notes
  attr_reader :password
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  class <<self
    alias_method :generate_activation_token, :generate_session_token
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil unless user
    return user if user.is_password?(password)
    nil
  end

  def reset_session_token!
    self.update_attributes(session_token: User.generate_session_token)
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def ensure_activation_token
    self.activation_token ||= User.generate_activation_token
  end

  # private

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest) == password
  end
end