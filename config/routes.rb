# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :admins

  resources :transactions, only: %i[index show]
  resources :merchants, only: %i[index show destroy]
  resources :merchant_customizations, only: %i[new create]

  namespace :api do
    namespace :v1 do
      resources :transactions, only: :create
    end
  end
end
