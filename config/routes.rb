LoopdIn::Application.routes.draw do
  root :to => "home#index"
  devise_for :users
  resources :users do

    resources :projects do
      resources :versions
    end
  end
end
