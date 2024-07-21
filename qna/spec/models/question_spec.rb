require 'rails_helper'

RSpec.describe Question, type: :model do
  it {should belong_to(:test)}

  it {should validate_presence_of :body }
end
