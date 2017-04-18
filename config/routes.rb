Rails.application.routes.draw do
  
  get 'letter_viewer/index'

  get 'letter_viewer/letterview'

  resources :love_letters


  match "/inputname" => "welcome#startHomeScreen", :via => :post, :as => :input_name
  root 'welcome#index'
end
