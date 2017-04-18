Rails.application.routes.draw do
<<<<<<< HEAD
  
  get 'welcome/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
=======

	resources :loveletters

	root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
>>>>>>> 2a6ff49e845a908f17287f4cef55ce97623ea04b
end
