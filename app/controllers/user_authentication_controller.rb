class UserAuthenticationController < ApplicationController
  # Uncomment this if you want to force users to sign in before any other actions
  # skip_before_action(:force_user_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie] })

  def sign_in_form
    render({ :template => "user_authentication/sign_in.html.erb" })
  end

  def create_cookie
    user = User.where({ :email => params.fetch("query_email") }).first
    
    the_supplied_password = params.fetch("query_password")
    
    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/user_sign_in", { :alert => "Incorrect password." })
      else
        session[:user_id] = user.id
      
        redirect_to("/", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/user_sign_in", { :alert => "No user with that email address." })
    end
  end

  def destroy_cookies
    reset_session

    redirect_to("/", { :notice => "Signed out successfully." })
  end

  def sign_up_form
    render({ :template => "user_authentication/sign_up.html.erb" })
  end

  def create
    @user = User.new
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.first_name = params.fetch("query_first_name")
    @user.last_name = params.fetch("query_last_name")

    save_status = @user.save

    if save_status == true
      session[:user_id] = @user.id
   
      redirect_to("/", { :notice => "User account created successfully."})
    else
      redirect_to("/user_sign_up", { :alert => "User account failed to create successfully."})
    end
  end
    
  def edit_profile_form
    render({ :template => "user_authentication/edit_profile.html.erb" })
  end

  def update
    @user = @current_user
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.first_name = params.fetch("query_first_name")
    @user.last_name = params.fetch("query_last_name")
    
    if @user.valid?
      @user.save

      redirect_to("/", { :notice => "User account updated successfully."})
    else
      render({ :template => "user_authentication/edit_profile_with_errors.html.erb" })
    end
  end

  def destroy
    @current_user.destroy
    reset_session
    
    redirect_to("/", { :notice => "User account cancelled" })
  end

  def notification_sign_up
   


    @user = User.where({ :email => params.fetch("query_email") }).first
    #@user.email = params.fetch("query_email")

  # Retrieve your credentials from secure storage
    mg_api_key = ENV.fetch("MAILGUN_API_KEY")
    mg_sending_domain = ENV.fetch("MAILGUN_SENDING_DOMAIN")

  # Create an instance of the Mailgun Client and authenticate with your API key
    mg_client = Mailgun::Client.new(mg_api_key)

  # Craft your email as a Hash with these four keys
  email_parameters =  { 
    :from => "umbrella@appdevproject.com",
    :to => @user.email ,  # Put your own email address here if you want to see it in action
    :subject => "Free Food Coming!",
    :text => "Keep an eye out for new posts!"
  }

  # Send your email!
  mg_client.send_message(mg_sending_domain, email_parameters)
  end

 
end
