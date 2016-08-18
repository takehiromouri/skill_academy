Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#home'

  resources :courses, only: [:index, :show] do
    resources :enrollments, only: [:create, :destroy]
    resources :ratings, only: [:create, :destroy]
  end

  namespace :instructor do
    resources :courses
  end

  namespace :user do
    resources :courses, only: :index
  end

  resources :users, only: :show

end
