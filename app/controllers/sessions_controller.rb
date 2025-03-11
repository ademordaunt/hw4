class SessionsController < ApplicationController
  def new
    # This action renders the login form (app/views/sessions/new.html.erb)
  end

  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        flash[:notice] = "You've logged in."
        session["user_id"] = @user["id"]
        redirect_to "/places"
      else
        flash[:notice] = "Unsuccessful login."
        redirect_to "/sessions/new"
      end
    else
      flash[:notice] = "Unsuccessful login."
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session["user_id"] = nil
    flash[:notice] = "Goodbye."
    redirect_to "/sessions/new"
  end
end
