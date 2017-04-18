Rails.application.routes.draw do
  
  resources :love_letters

  
 
  root 'welcome#index'
end
