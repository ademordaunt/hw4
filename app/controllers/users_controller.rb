class UsersController < ApplicationController
  def new
    # Renders the signup form.
  end

  def create
    @user = User.new
    @user["username"] = params["username"]
    @user["email"] = params["email"]
    @user["password"] = BCrypt::Password.create(params["password"])
    
    if @user.save
      redirect_to "/users/#{@user["id"]}"
    else
      redirect_to "/users/new"
    end
  end

  def show
    @user = User.find(params["id"])
  end
end