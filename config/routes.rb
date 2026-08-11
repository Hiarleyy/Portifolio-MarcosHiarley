Rails.application.routes.draw do
  # Devise authentication for admin
  devise_for :admin_users, path: 'admin', controllers: {
    sessions: 'admin/sessions'
  }

  # Admin namespace
  namespace :admin do
    root 'dashboard#index'
    resources :articles
    resources :projects
  end

  # Public routes
  resources :articles, only: [:index, :show]
  resources :projects, only: [:index, :show]

  # Static pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  post 'contact', to: 'pages#send_contact'

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root
  root "pages#home"
end
