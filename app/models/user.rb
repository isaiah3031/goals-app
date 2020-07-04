require 'bcrypt'
class User < ApplicationRecord
  validates :username, :password_digest, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  before_validation :ensure_session_token
  attr_reader :password

  has_many :goals,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Goal

  has_many :comments, as: :comment
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(@password)
  end

  def self.generate_session_token
    SecureRandom.base64
  end

  def reset_session_token
    self.session_token = User.generate_session_token
    save!
  end

  def ensure_session_token
    if self.session_token.nil?
      self.session_token = User.generate_session_token
    end
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if !!user && user.password?(password)

    nil
  end

  def password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end

