Smartset::Application.routes.draw do
	
	resources :countries
	resources :currencies
	resources :trips
	
	match "currency_countries", :to => "currencies#currency_countries", :as =>"currency_countries"
	match "country_currencies", :to => "countries#country_currencies", :as =>"country_currencies"
	
	match "/trips/destroy/:id", :to => "trips#destroy", :as =>"destroy_trip"
		
	# map.update_service "/update/service/:name", :controller=>"woodpecker", :action=>"update_service"
	match "update_country/:id", :to => "countries#update_country", :as =>"update_country"
	match "update_toggle", :to => "currencies#update_toggle", :as =>"update_toggle"
	
	match "update_trip_status/:id", :to => "trips#update_status", :as =>"update_trip_status"

	match '/logout', :to=> "sessions#destroy", :as=> "logout"
	match '/login', :to=> "sessions#new", :as=> "login"
	resources :users
  	resource :session
  	
	root :to => 'home#index'
end
