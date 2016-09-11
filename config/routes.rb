Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#home'

  resources :courses, only: [:index, :show] do
    resources :enrollments, only: [:create, :destroy]
    resources :ratings, only: [:create]    
    resources :lessons, only: [:index, :show]
  end

  resources :ratings, only: :destroy

  namespace :instructor do
    resources :courses do 
      resources :sections, only: [:new, :create]
    end
    resources :sections, only: [] do
      resources :lessons, only: [:new, :create]
    end
    resources :sections, only: :update
    resources :lessons, only: :update
  end

  namespace :user do
    resources :courses, only: :index
  end

  resources :users, only: :show

end
