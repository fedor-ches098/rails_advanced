Rails.application.routes.draw do

  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }
  root to: 'questions#index'

  devise_scope :user do
    post '/send_email' => 'oauth_callbacks#send_email'
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [] do
        get :me, on: :collection
      end
    end
  end

  concern :likable do
    member do
      post :vote_up, :vote_down
      delete :revoke
    end
  end

  concern :commentable do
    resources :comments, shallow: true
  end
  
  resources :questions, concerns: %i[likable commentable] do
    resources :answers, concerns: %i[likable commentable], shallow: true, except: %i[index show] do
      member do
        patch :best
      end
    end
  end

  resources :attachments, only: :destroy
  resources :links, only: :destroy
  resources :badges, only: :index

  mount ActionCable.server => '/cable'
end
