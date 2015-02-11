class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  has_secure_password
  #FIXME: It would be better not to allow blank password by removing password field from user edit form to some special form change password
  validates :password, length: { minimum: 6 }, allow_blank: true

  def User.digest(string)
#    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    cost = BCrypt::Engine::MIN_COST
    BCrypt::Password.create(string, cost: cost)
  end
end
