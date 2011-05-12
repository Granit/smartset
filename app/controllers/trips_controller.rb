class TripsController < ApplicationController
	before_filter :login_required, :except => [:index, :show]
	
	def index
		@trips = Trip.find(:all, :order => "created_at ASC")
		@visited_countries_size = Country.visited?(true).count
	end
	
	def show
		@trip = Trip.find(params[:id])
		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @trip }
		end
	end
  
	def new
		@trip = Trip.new
		@countries = Country.order("name").select{|country| country.visited == false}
		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @trip }
		end
	end
	
	def edit
		@trip= Trip.find(params[:id])
		@countries = Country.order("name").select{|country| country.visited == false}
	end

	def create
		@trip = Trip.new(params[:trip])
		unless params[:country_id].nil?
			params[:country_id].each{|country_id|
				@trip.countries.push(Country.find(country_id))
			}
		end
		respond_to do |format|
			if @trip.save
        		flash[:notice] = "Trip was successfully created."
        		format.html { redirect_to(@trip) }
        		format.xml  { render :xml => @trip, :status => :created, :location => @tripe }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @trip.errors, :status => :unprocessable_entity }
			end
		end
	end
	
	def update
		@trip = Trip.find(params[:id])
		respond_to do |format|
			if @trip .update_attributes(params[:trip ])
				flash[:notice] = 'Trip  was successfully updated.'
				format.html { redirect_to(@trip ) }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @trip .errors, :status => :unprocessable_entity }
			end
		end
	end

	def destroy
		@trip = Trip.find(params[:id])
		@trip.destroy #if current_user.id == @trip.user_id
		respond_to do |format|
			format.html { redirect_to(trips_url) }
			format.xml  { head :ok }
		end
	end
	
	def update_status	#params[:id]
			trip = Trip.find(params[:id])
			if trip['status']=='incompleted'
				trip['status']='completed'
				trip.save
			end
			
		redirect_to :back, :params => @params
	end
end
