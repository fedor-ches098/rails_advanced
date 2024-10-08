class Question < ApplicationRecord
  include Commentable
  include Likable
  
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable
  has_one :badge, dependent: :destroy
  has_many_attached :files, dependent: :destroy

  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user

  accepts_nested_attributes_for :links, reject_if: :all_blank 
  accepts_nested_attributes_for :badge, reject_if: :all_blank

  after_create { subscribe(user) }

  scope :per_day, -> { where(created_at: Date.today.all_day) }
  
  validates :title, :body, presence: true

  def subscribe(user)
    subscriptions.create(user: user) unless subscribed?(user)
  end

  def unsubscribe(user)
    subscriptions.find_by(user: user).destroy if subscribed?(user)
  end

  def subscribed?(user)
    subscriptions.exists?(user: user)
  end
end
