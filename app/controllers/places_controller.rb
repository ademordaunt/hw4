class PlacesController < ApplicationController
  # For the index action, if the user is not logged in, we display an empty list.
  def index
    if current_user
      @places = Place.all
    else
      @places = []   # Non-signed in users see no places.
    end
  end

  def new
    unless current_user
      flash[:notice] = "You must be logged in to add a new place."
      redirect_to "/login" and return
    end
    @place = Place.new
  end

  def create
    unless current_user
      flash[:notice] = "You must be logged in to add a new place."
      redirect_to "/login" and return
    end

    @place = Place.new
    @place["name"] = params["name"]
    # Add any additional attributes as needed.
    if @place.save
      flash[:notice] = "Place created successfully!"
      redirect_to "/places"
    else
      flash[:notice] = "There was a problem creating the place."
      render :new
    end
  end

  def show
    unless current_user
      flash[:notice] = "You must be logged in to view this place."
      redirect_to "/login" and return
    end
    @place = Place.find(params["id"])
    # Using the association to fetch entries that belong to this place and the current user.
    @entries = @place.entries.where(user_id: current_user["id"])
  end
  
  
end
