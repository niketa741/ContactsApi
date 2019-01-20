Rails.application.routes.draw do
	namespace :api do
  		resources :contacts
  	end

  	post '/api/contacts/:firstName', to: 'api/contacts#search_by_name'
  	post '/api/contacts/:email', to: 'api/contacts#search_by_email'

  	#post '', to: ''
  	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
