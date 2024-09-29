require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }
  root to: 'questions#index'

  devise_scope :user do
    post '/send_email' => 'oauth_callbacks#send_email'
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [:index] do
        get :me, on: :collection
      end

      resources :questions, except: %i[new edit] do 
        get :answers, on: :member
        resources :answers, shallow: true, except: %i[new edit index]
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
  
  resources :questions, concerns: %i[likable commentable], shallow: true do
    resources :answers, concerns: %i[likable commentable], except: %i[index show] do
      member do
        patch :best
      end
    end

    resources :subscriptions, only: %i[create destroy]
  end

  resources :attachments, only: :destroy
  resources :links, only: :destroy
  resources :badges, only: :index

  mount ActionCable.server => '/cable'
end
