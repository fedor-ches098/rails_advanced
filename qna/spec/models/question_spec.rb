require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:links).dependent(:destroy) }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_one :badge }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :links }
  it { should accept_nested_attributes_for :badge }

  it_behaves_like 'Likable' do 
    let(:other_users) { create_list(:user, 5) }
    let(:user) { create(:user) }
    let(:likable) { create(:question) }
  end

  it { should have_many_attached(:files) }
end
