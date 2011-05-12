begin
  namespace :database do
  	desc "Refresh country list"
    task :refresh_country => :environment do
      puts "Refreshing country list from soap server http://www.webservicex.net/country.asmx"
      SmodelController.new.refresh_country_list
    end
    
  	desc "Refresh currency list"
    task :refresh_currency => :environment do
      puts "Refreshing currency list from soap server http://www.webservicex.net/country.asmx"
      SmodelController.new.refresh_currency_list
    end
    
  end
end
