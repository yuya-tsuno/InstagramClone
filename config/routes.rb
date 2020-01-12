Rails.application.routes.draw do
  resources :feeds do

    collection do
      post :confirm
      patch :confirm
    end

    member do
      patch :confirm
    end

  end

  resources :users

  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]
end