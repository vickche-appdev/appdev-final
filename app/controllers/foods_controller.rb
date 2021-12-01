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

    render({ :template => "foods/show.html.erb" })
  end

  def create
    the_food = Food.new
    the_food.title = params.fetch("query_title")
    the_food.caption = params.fetch("query_caption")
    the_food.meals_avaliable = params.fetch("query_meals_avaliable")
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


  def location
    # Parameters: {"user_street_address"=>"Merchandise Mart, Chicago"}

    @street_address = params.fetch("user_street_address")

    @maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address + "&key=AIzaSyD8RrOFB0dPsF-leqeFJdmX3yOvcQbfNyY"

    @raw_json_string = open(@maps_url).read

    @parsed_json = JSON.parse(@raw_json_string)

    @results_array = @parsed_json.fetch("results")

    @first_result = @results_array.at(0)
    
    @geometry_hash = @first_result.fetch("geometry")

    @location_hash = @geometry_hash.fetch("location")

    @latitude = @location_hash.fetch("lat")
    @longitude = @location_hash.fetch("lng")

    render({ :template => "foods/index.html.erb" })

end

end
