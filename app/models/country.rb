class Country < ActiveRecord::Base

has_and_belongs_to_many :currencies

	def initialize(keys={})
		super
		self.visited ||= false
	end
	
	def self.get_countries
		require 'handsoap'
		Smodel.get_countries
	end
	
	def self.by_name(name)
		#find(:all, :conditions => ["name = ?", name.to_s])
		where(:name => name.to_s)[0]
	end
	
	def self.update_country(id)
		country = Country.find(id)
	
		unless country.nil?
		country.visited = !country.visited
		country.save
		end
#		unless params[:countrycode].nil?
#			redirect_to currency_countries_path(params[:countrycode])
#		else
#			redirect_to currency_countries_path(params[:name])
#		end
	end
	
	def visited?(id)
		find(:all, :conditions => ["name = ?", name.to_s])
	end
	def not_visited?(id)
		find(:all, :conditions => ["name = ?", name.to_s])
	end
end
