Rails.application.routes.draw do

	match 'letters/new_link_letter/:link_token' => 'letters#new_link_letter', :as => 'new_link_letter', :via => :get
	match 'letters/create_link_letter/:link_token' => 'letters#create_link_letter', :as => 'create_link_letter', :via => :post

	match 'letter_links/sent_letters/:link_token' => 'letter_links#sent_letters', :as => 'sent_letters', :via => :get

	match 'show_archived' => 'welcome#show_archived', :as => 'show_archived', :via => :get

	resources :letters do
		member do
			get 'unarchive'
			get 'archive'
			get 'show_archived'
		end
	end

	resources :unlock_time_holders do
		member do
			get 'set_now'
			get 'add_letter'
			get 'remove_letter'
		end
	end

	resources :letter_links do

		member do
			get 'linkNotFound'
			get 'newLetter'
			get 'error'
		end
	end

	root 'welcome#index'
end
