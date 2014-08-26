LoopdIn::Application.routes.draw do
  devise_scope :user do
    root to: "home#index"
  end
  devise_for :users
  resources :groups
  resources :home
  resources :demo
  resources :users do
    resources :projects do
      resources :versions do
        resources :comments
      end
    end
  end
end
