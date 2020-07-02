class User < ApplicationRecord
  has_many :tasks

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end
end
