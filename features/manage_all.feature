Feature: Manage all
 In order to manage private currency colection
 As a Mr. Smart
 I want to create and manage countries, currencies and trips

 Scenario: show countries
	Given I am running rake refresh tasks
	And I am on the countries page
#	Then show me the page
	When I am on the currencies page
#	Then show me the page

  Scenario: show currencies
	Given I am on the currencies page
	Then I should see "ISO"
	And I should see "Currency name (not visited / all countries)"
	And I should see "Collected?"
	Given I follow "View not visited"
#	Then show me the page

  Scenario Outline: show currency countries
	Given I am on the currencies page
	Given I follow "<currency>"
#	Then show me the page
	Then I should see "<country_1>"
	And I should see "<country_2>"
	And I should see "<country_3>"
	And I should see "<country_4>"
    Examples:
      | currency | country_1 |country_2 |country_3 |country_4 |
      | Dollar | Taiwan | Australia | Jamaica | United States |
      
      
	  Scenario Outline: authorize myself
	Given I am on the root page
    And There is user with Login "<user_login>", Email "<user_email>", Password "<user_password>" in database
    Then I should have 1 "user"
	And I am filling log_in form with Login "<user_login>", Password "<user_password>"
	Then I should see "You are logged in as <user_login>"
    Examples:
      | user_login | user_password | user_email |
      | admini |  admini | admini@gmail.com |
	
  Scenario Outline: add a new trip
	Given I am on the root page
    And There is user with Login "<user_login>", Email "<user_email>", Password "<user_password>" in database
    Then I should have 1 "user"
	And I am filling log_in form with Login "<user_login>", Password "<user_password>"
	Then I should see "You are logged in as <user_login>"
    Given I am on the new trip page
    And I should have 0 "trip"
#    Then show me the page
    When I fill in "trip_description" with "<trip_description>"
    And I select "incompleted" from "trip_status"
    
	When I check the "<country_1>" country
	When I check the "<country_2>" country
    And I press "Save"
 #  Then show me the page
    Then I should see "Show Trip"
    And I should see "<trip_description>"
	And I should see "<country_1>"
	And I should see "<country_2>"
	Then I should have 1 "trip"
	
    Examples:
      | user_login | user_password | user_email | trip_description | country_1 | country_2 |
      | admini |  admini | admini@gmail.com | description 1 | Albania | Ukraine |
      
  Scenario Outline: add a new trip and complete it	# and check number of visited countrie and collected currencies
	Given I am on the root page
    And There is user with Login "<user_login>", Email "<user_email>", Password "<user_password>" in database
    Then I should have 1 "user"
	And I am filling log_in form with Login "<user_login>", Password "<user_password>"
	Then I should see "You are logged in as <user_login>"
    Given I am on the new trip page
    And I should have 0 "trip"
    And I should have 0 "visited countries"
    And I should have 0 "collected currencies"
#    Then show me the page
    When I fill in "trip_description" with "<trip_description>"
    And I select "completed" from "trip_status"
    
	When I check the "<country_1>" country
	When I check the "<country_2>" country
    And I press "Save"
 #  Then show me the page
    Then I should see "Show Trip"
    And I should see "<trip_description>"
	And I should see "<country_1>"
	And I should see "<country_2>"
	Then I should have 1 "trip"
    And I should have 2 "visited countries"
    And I should have 2 "collected currencies"
	
    Examples:
      | user_login | user_password | user_email | trip_description | country_1 | country_2 |
      | admini |  admini | admini@gmail.com | description 1 | Albania | Ukraine |
      
  Scenario Outline: add a new trip and complete it another way	# and check number of visited countrie and collected currencies
	Given I am on the root page
    And There is user with Login "<user_login>", Email "<user_email>", Password "<user_password>" in database
    Then I should have 1 "user"
	And I am filling log_in form with Login "<user_login>", Password "<user_password>"
	Then I should see "You are logged in as <user_login>"
    Given I am on the new trip page
    And I should have 0 "trip"
    And I should have 0 "visited countries"
    And I should have 0 "collected currencies"
#    Then show me the page
    When I fill in "trip_description" with "<trip_description>"
    And I select "incompleted" from "trip_status"
    
	When I check the "<country_1>" country
	When I check the "<country_2>" country
    And I press "Save"
 #  Then show me the page
    Then I should see "Show Trip"
    And I should see "<trip_description>"
	And I should see "<country_1>"
	And I should see "<country_2>"
	Then I should have 1 "trip"
    And I should have 0 "visited countries"
    And I should have 0 "collected currencies"
    Given I am on the trips page
 #   Then show me the page
	When I follow image link "to_complete"
	Then I should have 1 "trip"
    And I should have 2 "visited countries"
    And I should have 2 "collected currencies"
	
    Examples:
      | user_login | user_password | user_email | trip_description | country_1 | country_2 |
      | admini |  admini | admini@gmail.com | description 1 | Albania | Ukraine |


 	@javascript
  Scenario Outline: mark country as visited # and check number of visited countries
	Given I am on the root page
    And There is user with Login "<user_login>", Email "<user_email>", Password "<user_password>" in database
    Then I should have 1 "user"
	And I am filling log_in form with Login "<user_login>", Password "<user_password>"
	Then I should see "You are logged in as <user_login>"
	And I should have 0 "visited countries"
    Given I am on the currencies page
	Then I follow "<currency>"
	#And show me the page
	When I check visited the "<country_1>" country
	Then I should have 1 "visited countries"
	And I should have 1 "collected currencies"
	When I check visited the "<country_2>" country
    Then I should have 2 "visited countries"
	And I should have 2 "collected currencies"
#   Then show me the page
    Examples:
      | user_login | user_password | user_email | currency | country_1 | country_2 |
      | admini |  admini | admini@gmail.com | Dollar | Australia | Canada |
           
  # Rails generates Delete links that use Javascript to pop up a confirmation
  # dialog and then do a HTTP POST request (emulated DELETE request).
  #
  # Capybara must use Culerity/Celerity or Selenium2 (webdriver) when pages rely
  # on Javascript events. Only Culerity/Celerity supports clicking on confirmation
  # dialogs.
  #
  # Since Culerity/Celerity and Selenium2 has some overhead, Cucumber-Rails will
  # detect the presence of Javascript behind Delete links and issue a DELETE request 
  # instead of a GET request.
  #
  # You can turn this emulation off by tagging your scenario with @no-js-emulation.
  # Turning on browser testing with @selenium, @culerity, @celerity or @javascript
  # will also turn off the emulation. (See the Capybara documentation for 
  # details about those tags). If any of the browser tags are present, Cucumber-Rails
  # will also turn off transactions and clean the database with DatabaseCleaner 
  # after the scenario has finished. This is to prevent data from leaking into 
  # the next scenario.
  #
  # Another way to avoid Cucumber-Rails' javascript emulation without using any
  # of the tags above is to modify your views to use <button> instead. You can
  # see how in http://github.com/jnicklas/capybara/issues#issue/12
  #

