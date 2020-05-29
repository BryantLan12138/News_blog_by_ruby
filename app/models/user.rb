class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token, :reset_token
    attr_accessor :remember_token
    has_many :posts, dependent: :destroy

    mount_uploader :image, AvatarUploader
    mount_uploader :card, AvatarUploader

    before_save { self.email = email.downcase }
    validates :name, presence:true, length: { maximum: 50 }, allow_nil: true
    validates :phone, presence:true, length: {minimum: 10, maximum: 13}, allow_nil: true
    VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    VALID_PASSWORD_REGEX = /\A(?=[0-9a-zA-Z]+\z)/
    validates :email, presence:true, length: { maximum: 255 },
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 8, maximum: 20 }, format: { with: VALID_PASSWORD_REGEX }, allow_nil: true

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    def User.new_token
      SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if remember_digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end   

    def forget
        update_attribute(:remember_digest, nil)
    end

    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest,  User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end
end
