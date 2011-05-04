module CurrenciesHelper

	def toggle_value(id)
		Country.update_country(id)
	end
end
