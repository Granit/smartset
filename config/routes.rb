Smartset::Application.routes.draw do
	
	resources :countries
	resources :currencies
	
	match "currency_countries", :to => "currencies#currency_countries", :as =>"currency_countries"
	
	# map.update_service "/update/service/:name", :controller=>"woodpecker", :action=>"update_service"
	match "update_country/:id", :to => "countries#update_country", :as =>"update_country"
	root :to => 'home#index'
end
