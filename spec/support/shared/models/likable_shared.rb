require 'rails_helper'

shared_examples_for 'Likable' do
  describe '#vote_up' do
    before { likable.vote_up(other_users[0]) }

    it 'changed raiting' do
      expect(likable.likes.last.rating).to eq 1
    end

    it 'like user is a @liker' do
      expect(likable.likes.last.user).to eq other_users[0]
    end

    it 'like likable is a @likable' do
      expect(likable.likes.last.likable).to eq likable
    end
  end

  describe '#vote_down' do
    before { likable.vote_down(other_users[0]) }

    it 'changed raiting' do
      expect(likable.likes.last.rating).to eq -1
    end

    it 'like user is a @liker' do
      expect(likable.likes.last.user).to eq other_users[0]
    end

    it 'like likable is a @likable' do
      expect(likable.likes.last.likable).to eq likable
    end
  end

  it '#rating_sum' do
    likable.vote_up(other_users[0])
    likable.vote_up(other_users[1])
    likable.vote_down(other_users[2])
    likable.vote_down(other_users[3])
    likable.vote_down(other_users[4])

    expect(likable.rating_sum).to eq -1
  end
end