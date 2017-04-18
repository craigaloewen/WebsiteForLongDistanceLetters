Rails.application.routes.draw do
  
  resources :love_letters


  match "/inputname" => "welcome#startHomeScreen", :via => :post, :as => :input_name
  root 'welcome#index'
end
