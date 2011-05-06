class Trip < ActiveRecord::Base

has_and_belongs_to_many :countries

before_save :update_visited_countries

	def initialize(keys={})
		super
		self.date ||= Time.now
		self.status ||= 'incompleted'
	end
	
	def update_visited_countries
		self.countries.each{|country|
			country.visited = true
			country.save
			#country.currencies.each{|currency|
			#	currency.collected = true
			#	currency.save	
			#}	
		}

	end
end
