class FoodsController < ApplicationController
  def index
    matching_foods = Food.all

    @list_of_foods = matching_foods.order({ :created_at => :desc })
    

    render({ :template => "foods/index.html.erb" })
  end


  def show
    the_id = params.fetch("path_id")

    matching_foods = Food.where({ :id => the_id })

    @the_food = matching_foods.at(0)

    @rsvped_foods = Rsvp.where({ :food_id => the_id})
    @user_rsvps = @rsvped_foods.where({ :user_id => session.fetch(:user_id)}).at(0)

#LOCATION MAP
#if the_food.location.valid?
@street_address = Food.where({ :id => the_id }).at(0)

@maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address.location + "&key=AIzaSyD8RrOFB0dPsF-leqeFJdmX3yOvcQbfNyY"


@raw_json_string = open(@maps_url).read

@parsed_json = JSON.parse(@raw_json_string)

@results_array = @parsed_json.fetch("results")

@first_result = @results_array.at(0)

@geometry_hash = @first_result.fetch("geometry")

@location_hash = @geometry_hash.fetch("location")

@latitude = @location_hash.fetch("lat").to_s
@longitude = @location_hash.fetch("lng").to_s

@location = @latitude + "," + @longitude 


@map = "https://www.google.com/maps/embed/v1/view?zoom=17&center="+ @location +"&key=AIzaSyD8RrOFB0dPsF-leqeFJdmX3yOvcQbfNyY"

#@map = "https://www.google.com/maps/embed/v1/view?zoom=12&center=" + @location + "&key=AIzaSyD8RrOFB0dPsF-leqeFJdmX3yOvcQbfNyY">












    render({ :template => "foods/show.html.erb" })

  end

  def create
    the_food = Food.new
    the_food.title = params.fetch("query_title")
    the_food.caption = params.fetch("query_caption")
    the_food.meals_avaliable = params.fetch("query_meals_avaliable")
    the_food.location = params.fetch("user_address")
    the_food.image = params.fetch(:query_image)
    the_food.user_id = session.fetch(:user_id)
    
   
    

    if the_food.valid?
      the_food.save
      redirect_to("/foods", { :notice => "Food created successfully." })
    else
      redirect_to("/foods", { :notice => "Food failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_food = Food.where({ :id => the_id }).at(0)

    the_food.title = params.fetch("query_title")
    the_food.caption = params.fetch("query_caption")
    the_food.meals_avaliable = params.fetch("query_meals_avaliable")
    the_food.image = params.fetch("query_image")
    the_food.user_id = params.fetch("query_user_id")
    the_food.location = params.fetch("user_address")

    if the_food.valid?
      the_food.save
      redirect_to("/foods/#{the_food.id}", { :notice => "Food updated successfully."} )
    else
      redirect_to("/foods/#{the_food.id}", { :alert => "Food failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_food = Food.where({ :id => the_id }).at(0)

    the_food.destroy

    redirect_to("/foods", { :notice => "Food deleted successfully."} )
  end





def address

  @street_address = params.fetch("user_address")

  render({ :template => "foods/index.html.erb" })

end




def notification_sign_up

  #@user = @current_user
  @user_email = params.fetch("user_email")

# Retrieve your credentials from secure storage
  mg_api_key = ENV.fetch("MAILGUN_API_KEY")
  mg_sending_domain = ENV.fetch("MAILGUN_SENDING_DOMAIN")

# Create an instance of the Mailgun Client and authenticate with your API key
  mg_client = Mailgun::Client.new(mg_api_key)

# Craft your email as a Hash with these four keys
email_parameters =  { 
  :from => "umbrella@appdevproject.com",
  :to => params.fetch("user_email") ,  # Put your own email address here if you want to see it in action
  :subject => "Free Food Coming!",
  :text => "Keep an eye out for new posts!"
}

# Send your email!
mg_client.send_message(mg_sending_domain, email_parameters)

if email_parameters.valid?
  redirect_to("/foods", { :notice => "Signed up successfully." })
else
  redirect_to("/foods", { :notice => "Failed to sign up successfully." })
end




end


end
