require 'rails_helper'

RSpec.describe Test, type: :model do
  it {should have_many(:questions).dependent(:destroy)}

  it {should validate_presence_of :title }
  it {should validate_numericality_of(:level).only_integer.is_greater_than_or_equal_to(0) }
end
