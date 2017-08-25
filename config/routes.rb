Rails.application.routes.draw do

	get    '/login',   to: 'sessions#new'
	post   '/login',   to: 'sessions#create'
	delete '/logout',  to: 'sessions#destroy'

	get  '/signup',  to: 'users#new'
  	post '/signup',  to: 'users#create'

	resources :users, param: :username do
		resources :jars, param: :site_url do
			resources :letter_links do
				get 'sent_letters', to: 'letter_links#sent_letters'
				member do
					get 'new_letter'
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
