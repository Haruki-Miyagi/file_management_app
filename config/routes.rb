# frozen_string_literal: true

Rails.application.routes.draw do
  resources :folders
  resources :rooms, except: %i[index] do
    resources :documents, except: %i[index] do
      member do
        get :download
      end
    end
  end

  resources :user_controll_rooms, only: [:create, :destroy]

  devise_for :users, only: %i[sign_in sign_up sessions registrations]
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
