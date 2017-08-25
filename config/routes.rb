Rails.application.routes.draw do

	resources :jars, param: :site_url do
		member do
			get 'admin'
		end
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

	root 'welcome#start_page'
end
