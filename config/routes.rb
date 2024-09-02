# filename: config/routes.rb
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      resource :session, only: [:create, :destroy] # Add this line
    end
  end
end
