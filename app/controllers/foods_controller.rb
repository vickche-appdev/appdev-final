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

    render({ :template => "foods/show.html.erb" })
  end

  def create
    the_food = Food.new
    the_food.title = params.fetch("query_title")
    the_food.caption = params.fetch("query_caption")
    the_food.meals_avaliable = params.fetch("query_meals_avaliable")
    the_food.image = params.fetch("query_image")
    the_food.user_id = params.fetch("query_user_id")

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
end