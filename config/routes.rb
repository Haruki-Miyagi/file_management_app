# frozen_string_literal: true

Rails.application.routes.draw do
  resources :folders, only: %i[index show new create]
  devise_for :users, only: %i[sign_in sign_up sessions registrations]
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
