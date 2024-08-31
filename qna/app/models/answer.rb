class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  default_scope -> { order(best: :desc) }
  scope :best, -> { where(best: true) }

  def best!
    transaction do
      question.answers.best.update_all(best: false)
      update(best: true)
    end
  end
end
