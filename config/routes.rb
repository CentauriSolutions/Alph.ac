# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # require "sidekiq/web"
  # mount Sidekiq::Web => '/sidekiq'
  resources :links
  scope '(:locale)', locale: /en/ do
    root to: 'pages#home'
  end
  get '/:id', to: 'links#show'
end
