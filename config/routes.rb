Rails.application.routes.draw do
  resources :memberships
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

      namespace :balances do
        get ':holder_type/:holder_id/:fruit_id' => 'balances#show'
        get ':holder_type/:holder_id' => 'balances#show_all'
      end

      scope :memberships do
        post 'create/:epicenter_type/:epicenter_id' => 'memberships#create'  
        post 'apply/:epicenter_type/:epicenter_id/:applicant_type/:applicant_id/:membership_id' => 'memberships#apply'
      end
      

      

      post 'transaction/:giver_type/:giver_id/:receiver_type/:receiver_id/fruit/:fruit_id/amount/:amount' => 'transactions#create'
    end
  end


end
