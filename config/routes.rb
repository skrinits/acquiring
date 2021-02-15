# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :admins

  namespace :api do
    namespace :v1 do
      resources :transactions, only: :create
    end
  end
end
