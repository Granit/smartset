class Country < ActiveRecord::Base

	has_and_belongs_to_many :trips
  has_many :monetizations, :dependent => :destroy
  has_many :currencies, :through => :monetizations

	before_save :update_visited_number, :update_collected_currencies
	
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
	
	def self.visited?(v)
		where(:visited => v)
	end
	
	def update_visited_number
		Monetization.by_country_id(self.id).each{|m|
			m.visited=self.visited
			m.save
		}
	end
	
	def update_collected_currencies
		self.currencies.each{|currency|
			currency.collected = true
			currency.save	
		}	
	end
end
