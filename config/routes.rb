# == Route Map
#

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'auth/create'
      delete 'auth/destroy'

      resources :administrators
      resources :jansous
      resources :games, only: %i(index update destroy)
      resources :matches do
        resources :games, only: %i(index create), controller: :match_games
      end
      resources :members
    end
  end
end
