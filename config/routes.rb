Rails.application.routes.draw do
 
  # Routes for the Rsvp resource:

  # CREATE
  post("/insert_rsvp", { :controller => "rsvps", :action => "create" })
          
  # READ
  get("/rsvps", { :controller => "rsvps", :action => "index" })
  
  get("/rsvps/:path_id", { :controller => "rsvps", :action => "show" })
  
  # UPDATE
  
  post("/modify_rsvp/:path_id", { :controller => "rsvps", :action => "update" })
  
  # DELETE
  get("/delete_rsvp/:path_id", { :controller => "rsvps", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
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

 

             
 
#Homepage
  get("/", { :controller => "foods", :action => "index" }) 




  #rails generate draft:resource bookmark user_id:integer movie_id:integer

end

