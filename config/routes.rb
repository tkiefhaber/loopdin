LoopdIn::Application.routes.draw do
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  devise_for :users
  resources :users do
    resources :projects do
      resources :versions do
        resources :comments
      end
    end
  end
end
