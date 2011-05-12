Given /^I am filling log_in form with Login "([^\"]*)", Password "([^\"]*)"$/ do |login, password|
    fill_in "login", :with => login
    fill_in "password", :with => password
    click_button "Log in"
end

Given /^I am filling register form with Login "([^\"]*)", Email "([^\"]*)", Password "([^\"]*)", Confirm Password "([^\"]*)"$/ do |login, email, password, confirm_password|
    fill_in "user_login", :with => login
    fill_in "user_email", :with => email
    fill_in "user_password", :with => password
    fill_in "user_password_confirmation", :with => confirm_password
    click_button "Sign up"
end

Then /^(?:|There )is user with Login "([^\"]*)", Email "([^\"]*)", Password "([^\"]*)" in database$/ do |login, email, password|
	u=User.new('login'=>login,:password=>password, :password_confirmation=>password, :email=>email)
	u.save
end

Then /^I should have ([0-9]+) "([^\"]*)"$/ do |count, tablename|
	if tablename=="visited countries"
		visited_countries = Country.visited?(true).count
		puts "#{tablename}="+visited_countries.to_s+" | #{count}"
		visited_countries.should == count.to_i
	elsif tablename=="collected currencies"
		collected_currencies = Currency.collected?(true).count
		puts "#{tablename}="+collected_currencies.to_s+" | #{count}"
		collected_currencies.should == count.to_i
	else
		puts "#{tablename}="+tablename.capitalize.constantize.all.count.to_s+" | #{count}"
		tablename.capitalize.constantize.all.count.should == count.to_i
	end
end

When /^I am running rake refresh tasks$/ do
	require "rake"
	@rake = Rake::Application.new
	system "rake database:refresh_country"

	system "rake database:refresh_currency"
end

When /^I check the "(.+?)" country$/ do |name|
  	id = ""
  	page.all('label').each_with_index {|l, i|
  		if (!l[:name].nil? && l[:name].strip == name.strip)
  			l.check("country_id_")
  		end
  	}
end

When /^I check visited the "(.+?)" country$/ do |name|
  	id = ""
  	page.all('label').each_with_index {|l, i|
  		if (!l[:name].nil? && l[:name].strip == name.strip)
  		puts "#{l[:name]}"
  		puts l.check("country_visited")
  		end
  	}
end

When /^I follow image link "([^"]*)"$/ do |img_id|
    find(:xpath, "//img[@id = '#{img_id}']/parent::a").click()
end


