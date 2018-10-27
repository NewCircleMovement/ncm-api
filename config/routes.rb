Rails.application.routes.draw do
  resources :tribes
  resources :movements
  resources :events
  resources :users
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resources :users
      resources :events
      resources :fruits

      get 'balances/:holder_type/:holder_id/:fruit_id' => 'balances#show'
      get 'balances/:holder_type/:holder_id' => 'balances#show_all'

      post 'transaction/:giver_type/:giver_id/:receiver_type/:receiver_id/fruit/:fruit_id/amount/:amount' => 'transactions#create'
    end
  end


end
