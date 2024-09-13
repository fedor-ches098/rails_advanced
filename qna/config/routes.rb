Rails.application.routes.draw do

  devise_for :users
  root to: 'questions#index'

  concern :likable do
    member do
      post :vote_up, :vote_down
      delete :revoke
    end
  end
  
  resources :questions, concerns: :likable do
    resources :answers, concerns: :likable, shallow: true, except: %i[index show] do
      member do
        patch :best
      end
    end
  end

  resources :attachments, only: :destroy
  resources :links, only: :destroy
  resources :badges, only: :index
end
