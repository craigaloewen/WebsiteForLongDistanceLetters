Rails.application.routes.draw do

  get '/love_letters/no_access', to: 'love_letters#no_access'

  resources :love_letters
  resources :unlock_time_holders

  root 'welcome#index'
end
