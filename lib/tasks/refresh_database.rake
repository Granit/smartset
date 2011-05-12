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
    
  	desc "Refresh country and currency"
    task :refresh_all => :environment do
      puts "Refreshing country list from soap server http://www.webservicex.net/country.asmx"
      SmodelController.new.refresh_country_list
      puts "Refreshing currency list from soap server http://www.webservicex.net/country.asmx"
      SmodelController.new.refresh_currency_list
    end
    
  	desc "Register owner of collection"
    task :register_owner => :environment do
      

    end
    desc "Register owner of collection"
    task :register_owner, [:login, :password] => :environment do |t, args|
		args.with_defaults(:login => "Smart", :password => "verysmart")
		puts "Registering owner with login #{args.login} and password #{args.password}"
		u=User.new('login'=>args.login,:password=>args.password, :password_confirmation=>args.password, :email=>"admin@gmail.com")
		u.save
   end

  end
end
