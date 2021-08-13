# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :codes, only: %i[create] do
        get ':token/:problem_id/:language_id', to: 'codes#show', on: :collection
        get 'all/:token/:problem_id/:language_id', to: 'codes#index', on: :collection
      end
    end
  end
end
