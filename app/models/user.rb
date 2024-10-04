class User < ApplicationRecord
  has_many :questions
  has_many :answers
  has_many :badges
  has_many :likes
  has_many :authorizations, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:github, :vkontakte]

  def author?(obj)
    obj.user_id == id
  end

  def award_badge!(badge)
    badges << badge
  end

  def liked?(item)
    likes.exists?(likable: item)
  end

  def self.find_for_oauth(auth, email)
    Services::FindForOauth.new(auth, email).call
  end

  def self.find_by_auth(auth)
    Authorization.find_by(provider: auth.provider, uid: auth.uid.to_s)&.user
  end

  def self.find_or_create(email)
    user = User.find_by(email: email)
    user || create_with_rand_password!(email)
  end

  def self.create_with_rand_password!(email)
    password = Devise.friendly_token[0, 20]
    User.create!(email: email, password: password, password_confirmation: password)
  end

  def create_authorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid)
  end
end
