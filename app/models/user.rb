class User < ApplicationRecord
  attr_accessor :remember_token
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: true
  validates :password, presence: true,
                       length: { minimum: 6 }

  before_save { email.downcase! }
  after_create :remember
  has_many :posts

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(token, cost: cost)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    #debugger
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
end
