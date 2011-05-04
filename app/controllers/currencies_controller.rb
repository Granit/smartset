class CurrenciesController < ApplicationController

	def index
			@currencies = Currency.all
			@countries_by_currencyname = {}
			@not_visited_countries_by_currencyname = {}
			@countries_by_currencycode = {}
			@not_visited_countries_by_currencycode = {}
			
			@currencies.each{|currency|
				@countries_by_currencyname["#{currency.name}"] ||=0
				@not_visited_countries_by_currencyname["#{currency.name}"] ||=0
				@countries_by_currencycode["#{currency.currencycode}"] ||=0
				@not_visited_countries_by_currencycode["#{currency.currencycode}"] ||=0
			
				currency.countries.each{|country|
					@countries_by_currencycode["#{currency.currencycode}"] +=1
					@not_visited_countries_by_currencycode["#{currency.currencycode}"] +=1 if country['visited']==false
					@countries_by_currencyname["#{currency.name}"] +=1
					@not_visited_countries_by_currencyname["#{currency.name}"] +=1 if country['visited']==false
				}
			}
	end
	
	def currency_countries
		unless params[:currencycode].nil?
			@currencies = Currency.by_currencycode(params[:currencycode])
		else
			@currencies = Currency.by_name(params[:name])
		end
			@currency_countries = []
			@currencies.each{|currency|
			@currency_countries += currency.countries
			}

	end
end
