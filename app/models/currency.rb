class Currency < ActiveRecord::Base

has_and_belongs_to_many :countries

	def self.by_name(name)
		#find(:all, :conditions => ["name = ?", name.to_s])
		where(:name => name.to_s)
	end
	
	def self.by_currencycode(code)
		#find(:all, :conditions => ["name = ?", name.to_s])
		where(:currencycode => code.to_s)
	end
	

end
