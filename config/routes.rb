Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

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
    resources :schools, only: [:edit, :update]
  end

  namespace :teachers do
    resources :assignments, only: :show
  end

  get '/assign', to: 'algo#assign'
end
