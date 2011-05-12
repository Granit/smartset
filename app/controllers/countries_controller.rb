class CountriesController < ApplicationController
	before_filter :login_required, :except => [:index]
	def index
			@countries = Country.order("name")
	end
	
	def country_currencies
			@country = Country.find(params[:id])
			@country_currencies = @country.currencies
	end
	
	def update_country	#params[:id]
		country = Country.find(params[:id])
			unless country.nil?
			country.visited = !country.visited
			country.save
			end
			#render :update do |page|
     	 	#	page.replace_html "c_#{country.id}"
			#end
			render :update do |page|
			page.redirect_to :back
			end
	end
	
end
