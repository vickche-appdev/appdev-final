Rails.application.routes.draw do
 
  # Routes for the User resource:

  # CREATE
  post("/insert_user", { :controller => "users", :action => "create" })
          
  # READ
  get("/users", { :controller => "users", :action => "index" })
  
  get("/users/:path_id", { :controller => "users", :action => "show" })
  
  # UPDATE
  
  post("/modify_user/:path_id", { :controller => "users", :action => "update" })
  
  # DELETE
  get("/delete_user/:path_id", { :controller => "users", :action => "destroy" })

  #------------------------------

  # Routes for the Food resource:

  # CREATE
  post("/insert_food", { :controller => "foods", :action => "create" })
          
  # READ
  get("/foods", { :controller => "foods", :action => "index" })
  
  get("/foods/:path_id", { :controller => "foods", :action => "show" })
  
  # UPDATE
  
  post("/modify_food/:path_id", { :controller => "foods", :action => "update" })
  
  # DELETE
  get("/delete_food/:path_id", { :controller => "foods", :action => "destroy" })

  #------------------------------

  #------------------------------

  # Routes for the Food resource:

  # CREATE
  post("/insert_food", { :controller => "foods", :action => "create" })
          
  # READ
  get("/foods", { :controller => "foods", :action => "index" })
  
  get("/foods/:path_id", { :controller => "foods", :action => "show" })
  
  # UPDATE
  
  post("/modify_food/:path_id", { :controller => "foods", :action => "update" })
  
  # DELETE
  get("/delete_food/:path_id", { :controller => "foods", :action => "destroy" })

             
 
#Homepage
  get("/", { :controller => "foods", :action => "index" }) 


 # Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  likes_count     :integer
#  password_digest :string
#  private         :boolean
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

#

  #rails generate draft:resource bookmark user_id:integer movie_id:integer

end

