class EntriesController < ApplicationController
  def index
    if current_user
      # Only display entries for the current user.
      @entries = Entry.where(user_id: current_user["id"])
    else
      flash["notice"] = "You must be logged in to view your entries."
      redirect_to "/login"
    end
  end

  def new
    if current_user
      @entry = Entry.new
    else
      flash["notice"] = "You must be logged in to create a new entry."
      redirect_to "/login"
    end
  end

  def create
    if current_user
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["place_id"] = params["place_id"]
      # Assign the new entry to the logged-in user.
      @entry["user_id"] = current_user["id"]
      if @entry.save
        flash["notice"] = "Entry created successfully!"
        redirect_to "/places/#{@entry["place_id"]}"
      else
        flash["notice"] = "There was a problem creating your entry."
        render :new
      end
    else
      flash["notice"] = "You must be logged in to create an entry."
      redirect_to "/login"
    end
  end
end