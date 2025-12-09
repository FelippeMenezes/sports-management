Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users

  resources :teams, only: [:index, :show, :new, :create] do
    get 'dashboard', on: :member, to: 'pages#dashboard'
  end

  # Routes for job progress tracking
  get 'job_progress/:job_id', to: 'job_progress#progress', as: 'job_progress'
  get 'job_status/:job_id', to: 'job_progress#status', as: 'job_status'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
