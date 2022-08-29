Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :area do
    resources :schools, only: [:index, :show] do
      resources :assignments, only: [:edit, :update]
    end
    resources :assignments do
      resources :teachers, only: :index
    end
  end

  namespace :schools do
    resources :assignments, only: [:index, :new, :create, :show]
  end

  namespace :teachers do
    resources :assignments, only: :show
  end
end
