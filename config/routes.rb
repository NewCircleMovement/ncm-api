Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  resources :memberships
  resources :tribes
  resources :movements
  resources :events
  resources :users

  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resources :users
      resources :events
      resources :fruits

      scope "epicenters/(:epicenter_type)/(:epicenter_id)" do
        resources :events, :key => :event_id
        
        resources :memberships, :key => :membership_id do
          post 'enrol/:applicant_type/:applicant_id' => 'memberships#enrol'
        end

        resources :fruits, :key => :fruit_id do
          post 'give/:amount/to/:receiver_type/:receiver_id' => 'epicenters#give_fruit'
          get 'balance' => 'epicenters#balance'
          get 'transactions' => 'epicenters#transactions'
          get 'transactions_given' => 'epicenters#transactions_given'
          get 'transactions_received' => 'epicenters#transactions_received'
        end


      end

      # resources :movements, :tribes do
      #   resources :memberships, key: :membership_id do
      #     post 'apply/:applicant_type/:applicant_id' => 'memberships#apply'
      #   end
      # end


      # scope :memberships do
      #   post 'create/:epicenter_type/:epicenter_id' => 'memberships#create'  
      #   post 'apply/:epicenter_type/:epicenter_id/:applicant_type/:applicant_id/membership/:membership_id' => 'memberships#apply'
      # end

      scope :balances do
        get ':holder_type/:holder_id/:fruit_id' => 'balances#show'
        get ':holder_type/:holder_id' => 'balances#show_all'
      end
      
      scope :transactions do
        post 'create/:giver_type/:giver_id/:receiver_type/:receiver_id/fruit/:fruit_id/amount/:amount' => 'transactions#create'
      end
      

      
    end
  end


end
