class Currency < ActiveRecord::Base

#has_and_belongs_to_many :countries
  has_many :monetizations, :dependent => :destroy
  has_many :countries, :through => :monetizations

	def initialize(keys={})
		super
		self.collected ||= false
	end
	
	def self.by_name(name)
		#find(:all, :conditions => ["name = ?", name.to_s])
		where(:name => name.to_s)
	end
	
	def self.by_currencycode(code)
		#find(:all, :conditions => ["name = ?", name.to_s])
		where(:currencycode => code.to_s)
	end
	
	def self.by_visited(v)
		self.all.select {|currency| currency.monetizations[0].visited == v}
	end
	
	def self.by_visited_and_name(v, name)
		self.where(:name => name).select {|currency| currency.monetizations[0].visited == v}
	end
	
end
