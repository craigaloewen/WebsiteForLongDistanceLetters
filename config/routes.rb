Rails.application.routes.draw do

	resources :jars, param: :site_url do
		get 'login', to: 'sessions#new'
		post 'login', to: 'sessions#create'
		delete 'logout', to: 'sessions#destroy'
		get 'admin_login', to: 'sessions#admin_new'
		post 'admin_login', to: 'sessions#admin_create'
		delete 'admin_logout', to: 'sessions#admin_destroy'
		member do
			get 'admin'
			get 'add_letter_count'
			get 'remove_letter_count'
			get 'show_archived'
			get 'error'
		end
		resources :letters do
			member do
				get 'unarchive'
				get 'archive'
				get 'show_archived'
			end
		end
		resources :letter_links, param: :token, only: [:index, :new, :create, :destroy]
	end

	resources :letter_links, param: :token, only: [:show] do
		get 'sent_letters', to: 'letter_links#sent_letters'
		get 'new_letter', to: 'letters#new_link_letter'
		post 'create_link_letter', to: 'letters#create_link_letter'
		member do
			get 'sent_letters'
			get 'error'
		end
	end

	root 'welcome#start_page'
end
