class Answer < ApplicationRecord
  include Commentable
  include Likable
  
  belongs_to :question
  belongs_to :user
  has_many_attached :files
  has_many :links, dependent: :destroy, as: :linkable

  accepts_nested_attributes_for :links, reject_if: :all_blank

  after_commit :notify, on: :create
  
  validates :body, presence: true

  default_scope -> { order(best: :desc) }
  scope :best, -> { where(best: true) }

  def best!
    transaction do
      question.answers.best.update_all(best: false)
      update(best: true)
    end
  end

  def notify
    NewAnswerJob.perform_later(self)
  end
end
