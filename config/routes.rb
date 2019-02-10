Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   root to: "dashboard#index"
  namespace :api do
    resources :users do
    end
  end
  
  # Trial
  devise_scope :user do
    get 'registrieren', :to => 'devise/registrations#new_trial'
    post 'registrieren' => 'devise/registrations#create_trial', as: :registration_trial
  end
  
  get 'trial/veranstaltungsort' => 'trial#trial_place', as: :trial_place
  post 'trial/veranstaltungsort' => 'trial#create_trial_place', as: :create_trial_place
  
  get 'trial/event' => 'trial#trial_event', as: :trial_event
  post 'trial/event' => 'trial#create_trial_event', as: :create_trial_event
  
  get 'trial/payment' => 'trial#trial_payment', as: :trial_payment
  patch 'trial/payment' => 'trial#create_trial_payment', as: :create_trial_payment
  
  get 'trial/rechnung' => 'trial#trial_bill', as: :trial_bill
  post 'trial/rechnung' => 'trial#create_trial_bill', as: :create_trial_bill

  get 'trial/code' => 'trial#trial_code', as: :trial_code

  get 'kostenlos' => 'trial#trial_free', as: :free
  post 'kostenlos' => 'trial#trial_free_code',  as: :trial_free_code
  
  
  get 'konto-freischalten' => 'trial#freischalten', as: :freischalten
  
  patch 'user-akutalisieren' => 'user#update', as: :update_user
  
  post 'konto-einstellung' => 'user#change', as: :change_user
  
  get 'event/:id' => 'event#edit', as: :edit_event
  patch 'event/:id' => 'event#update', as: :update_event
  post 'event-erstellen' => 'event#create', as: :create_event
  delete 'event-löschen' => 'event#destroy', as: :destroy_event
  post 'place-erstellen' => 'place#create', as: :create_place
  delete 'place-löschen' => 'place#destroy', as: :destroy_place
end
