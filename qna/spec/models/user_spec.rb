require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many(:authorizations).dependent(:destroy) }

  describe '.find_for_oauth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }
    let(:service) { double('Services::FindForOauth') }

    it 'calls Services::FindForOauth' do
      expect(Services::FindForOauth).to receive(:new).with(auth, user.email).and_return(service)
      expect(service).to receive(:call)
      User.find_for_oauth(auth, user.email)
    end
  end

  describe '.find_or_create' do
    let!(:user) { create(:user) }

    it 'find need user by email' do
      expect(User.find_or_create(user.email)).to eq user
    end

    it 'creates new user' do
      expect { User.find_or_create('user@mail.ru') }.to change(User, :count).by(1)
    end
  end

  describe '.create_with_rand_password!' do
    it 'creates new user' do
      expect { User.create_with_rand_password!('user@mail.ru') }.to change(User, :count).by(1)
    end

    it 'creates user with email in arg' do
      expect(User.create_with_rand_password!('user@mail.ru')).to eq User.find_by(email: 'user@mail.ru')
    end
  end

  describe '.find_by_auth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }

    it 'returns the user' do
      user.authorizations.create(provider: 'facebook', uid: '123456')

      expect(User.find_by_auth(auth)).to eq user
    end
  end
end
