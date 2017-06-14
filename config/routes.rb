Rails.application.routes.draw do

	match 'letters/new_link_letter/:link_token' => 'letters#new_link_letter', :as => 'new_link_letter', :via => :get
	match 'letters/create_link_letter/:link_token' => 'letters#create_link_letter', :as => 'create_link_letter', :via => :post


	match 'show_archived' => 'welcome#show_archived', :as => 'show_archived', :via => :get

	get    '/login',   to: 'sessions#new'
	post   '/login',   to: 'sessions#create'
	delete '/logout',  to: 'sessions#destroy'

	get  '/signup',  to: 'users#new'
  	post '/signup',  to: 'users#create'

	resources :users do
		resources :jars do
			resources :letter_links do
				get 'sent_letters', to: 'letter_links#sent_letters'
				member do
					get 'newLetter'
					get 'error'
				end
			end
			resources :letters do
				member do
					get 'unarchive'
					get 'archive'
					get 'show_archived'
				end
			end
		end
	end

	

	root 'welcome#testhomepage'
end
