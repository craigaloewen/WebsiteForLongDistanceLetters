Rails.application.routes.draw do



	resources :letters do
		member do
			get 'unarchive'
		end
	end

	resources :unlock_time_holders

	resources :letter_links do

		member do
			get 'linkNotFound'
			get 'newLetter'
		end
	end

	root 'welcome#index'
end
