Rails.application.routes.draw do
  resources :feeds do
    collection do
      post :confirm
    end
  end
end
