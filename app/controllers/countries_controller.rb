class CountriesController < ApplicationController

	def index
		#require "#{RAILS_ROOT}/app/models/smodel"
		#@countries = Country.get_countries# rescue []
		#if (params[:countries].nil?)
			@countries = Country.order("name")
		#else
		#	@countries = params[:countries]
		#end
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
