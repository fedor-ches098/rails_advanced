require 'rails_helper'

shared_examples_for 'Liked' do
  describe 'POST #vote_up' do
    context 'current user is not author of resource' do
      before { login(second_user) }

      it 'try to add new like' do
        expect { post :vote_up, params: { id: likable } }.to change(likable.likes, :count)
      end
    end

    context 'current user is author of resource' do
      before { login(likable.user) }

      it 'can not add new like' do
        expect { post :vote_up, params: { id: likable } }.to_not change(likable.likes, :count)
      end
    end

    describe 'POST #vote_down' do
      context 'current user is not author of resource' do
        before { login(second_user) }

        it 'try to add new dislike' do
          expect { post :vote_down, params: { id: likable } }.to change(likable.likes, :count)
        end
      end
    end

    context 'current user is author of resource' do
      before { login(likable.user) }

      it 'can not add new dislike' do
        expect { post :vote_down, params: { id: likable } }.to_not change(likable.likes, :count)
      end
    end

    describe 'DELETE #revoke' do
      context 'current user revoke his like' do
        before { login(second_user) }

        it 'delete like' do
          post :vote_up, params: { id: likable }
          expect { delete :revoke, params: { id: likable } }.to change(likable.likes, :count).by(-1)
        end
      end
    end
  end
end