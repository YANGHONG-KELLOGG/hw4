class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({"email"=>params["email"]})
    
    if @user
        # if user exists
        if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] =@user["id"]
            # send them to places
        flash["notice"] = "Welcome, #{@user["username"]}."
        redirect_to "/places"
        
        else
        #otherwise, back to login
        flash["notice"] = "Password not right"
        redirect_to "/login"
        end
    else
    #otherwise, back to login
    flash["notice"] = "No user found"
    redirect_to "/login"
    end 
end 


def destroy
    flash["notice"] = "Goodbye."
    session["user_id"] = nil
    redirect_to "/login"
  end

end
  