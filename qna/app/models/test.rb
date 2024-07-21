class Test < ApplicationRecord
  has_many :questions, dependent: :destroy

  validates :title, presence: true
                                  
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
