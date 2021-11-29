class RsvpsController < ApplicationController
  def index
    matching_rsvps = Rsvp.all

    @list_of_rsvps = matching_rsvps.order({ :created_at => :desc })

    matching_foods = Food.all

    @list_of_foods = matching_foods.order({ :created_at => :desc })

    render({ :template => "rsvps/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_rsvps = Rsvp.where({ :id => the_id })

    @the_rsvp = matching_rsvps.at(0)

    render({ :template => "rsvps/show.html.erb" })
  end

  def create
    the_rsvp = Rsvp.new
    the_rsvp.user_id = params.fetch("query_user_id")
    the_rsvp.food_id = params.fetch("query_food_id")

    if the_rsvp.valid?
      the_rsvp.save
      redirect_to("/rsvps", { :notice => "Rsvp created successfully." })
    else
      redirect_to("/rsvps", { :notice => "Rsvp failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_rsvp = Rsvp.where({ :id => the_id }).at(0)

    the_rsvp.user_id = params.fetch("query_user_id")
    the_rsvp.food_id = params.fetch("query_food_id")

    if the_rsvp.valid?
      the_rsvp.save
      redirect_to("/rsvps/#{the_rsvp.id}", { :notice => "Rsvp updated successfully."} )
    else
      redirect_to("/rsvps/#{the_rsvp.id}", { :alert => "Rsvp failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_rsvp = Rsvp.where({ :id => the_id }).at(0)

    the_rsvp.destroy

    redirect_to("/rsvps", { :notice => "Rsvp deleted successfully."} )
  end
end
