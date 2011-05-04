class SmodelController < ApplicationController

	def refresh_country_list
		Country.all.each{|c| c.destroy }
		#catch_errors(10){
			@countries = Smodel.get_countries
		#} rescue @countries = []
		
		@countries.each{|country|
		Country.new(:name=>country['name']).save
		sleep 0.001
		}
		
		redirect_to :back, :params => params
	end
	
	def refresh_currency_list
		Currency.all.each{|c| c.destroy }
		#catch_errors(10){
			@currencies = Smodel.get_currencies
		#} rescue @countries = []
		
		@currencies.each{|currency|
		c = Currency.new(:name=>currency['currency'], :currencycode=>currency['currencycode'])
		country = Country.by_name(currency['name'])
		unless country.nil?
			country['countrycode']=currency['countrycode']
			country.save
			c.countries.push(country)
		end
		c.save
		sleep 0.001
		}
		
		redirect_to :back, :params => params
	end
	
end
