require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }
  it { should belong_to :user }
  it { should have_many(:links).dependent(:destroy) }

  it { should accept_nested_attributes_for :links }

  it {should validate_presence_of :body }

  it_behaves_like 'Likable' do 
    let(:other_users) { create_list(:user, 5) }
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }
    let(:likable) { create(:answer, question: question, user: user) }
  end
end
