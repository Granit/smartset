class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
#  include AuthenticatedSystem
  

  # render new.rhtml
  def new
    @user = User.new
  end
=begin
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    #success = @user && @user.save
  #  if verify_recaptcha
    	success =  @user && @user.save
    	if success && @user.errors.empty?
    	
    		#	UserMailer.deliver_registration_confirmation(@user)
    		
    		
            # Protects against session fixation attacks, causes request forgery
		  # protection if visitor resubmits an earlier form using back
		  # button. Uncomment if you understand the tradeoffs.
		  # reset session
		  self.current_user = @user # !! now logged in
		  #redirect_back_or_default('/', :notice => "Thanks for signing up!  We're sending you an email with your activation code.")
		  #redirect_to "/home.html"
		  redirect_back_or_default('/', :notice => "Thanks for signing up!")
		else
		  flash.now[:error]  = "We couldn't set up that account, sorry.  Please try again."
		  render :action => 'new'
		end
	#else
#		flash[:error] = "The words do not match the ones in the recaptcha image!"
#		render :action => 'new'
#	end
  end
=end
end
