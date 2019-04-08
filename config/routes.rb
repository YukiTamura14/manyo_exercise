# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'tasks#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :admin do
    resources :users
  end

  resources :users
  resources :tasks
  resources :labels, except: [:show]
end
