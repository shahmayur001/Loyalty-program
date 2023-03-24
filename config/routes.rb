# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :transactions
  resources :users
  get '/rewards' => 'users_rewards#index', as: 'rewards'
  root 'transactions#index'
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
