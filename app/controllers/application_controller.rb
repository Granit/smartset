class ApplicationController < ActionController::Base
  protect_from_forgery
	include AuthenticatedTestHelper
	include AuthenticatedSystem
end
