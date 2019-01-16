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
  
  patch 'user-akutalisieren' => 'user#update', as: :update_user
  
  get 'event/:id' => 'event#edit', as: :edit_event
  patch 'event/:id' => 'event#update', as: :update_event
  post 'event-erstellen' => 'event#create', as: :create_event
  delete 'event-löschen' => 'event#destroy', as: :destroy_event
  post 'place-erstellen' => 'place#create', as: :create_place
  delete 'place-löschen' => 'place#destroy', as: :destroy_place
end
