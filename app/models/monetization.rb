class Monetization < ActiveRecord::Base
  belongs_to :currency
  belongs_to :country
  
#  	before_save :update_visited_number
  	
  	def initialize(keys={})
		super
		self.visited_numbers ||=0
		self.visited ||=false
	end

	
	def update_visited_number
		country = Country.find(self.country_id) rescue country=nil
		unless country.nil?
			if Country.find(self.country_id).visited
				self.visited_numbers=1
			else
				self.visited_numbers=0
			end
		end
	end
	
	def self.by_currency_id(currency_id)
		where(:currency_id => currency_id.to_s)
	end
	
	def self.by_country_id(country_id)
		where(:country_id => country_id.to_s)
	end
	
	def self.by_visited(visited)
		where(:visited => visited)
	end
	
end

