Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :epicenters
      resources :users, controller: 'epicenters', type: 'User'
      resources :events, controller: 'epicenters', type: 'Event'
      resources :centers, controller: 'epicenters', type: 'Center'

      resources :fruits
      

      post 'transaction/giver/:giver_id/receiver/:receiver_id/fruit/:fruit_id/amount/:amount' => 'fruit_transactions#create'
    end
  end


end
