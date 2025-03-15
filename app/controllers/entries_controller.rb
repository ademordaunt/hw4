class EntriesController < ApplicationController
  def index
    unless current_user
      flash[:notice] = "You must be logged in to view entries."
      redirect_to "/login" and return
    end
    @entries = Entry.where(user_id: current_user["id"])
  end

  def new
    unless current_user
      flash[:notice] = "You must be logged in to create a new entry."
      redirect_to "/login" and return
    end
    @entry = Entry.new
  end

  def create
    unless current_user
      flash[:notice] = "You must be logged in to create an entry."
      redirect_to "/login" and return
    end
  
    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry["place_id"] = params["place_id"]
    # Assign the entry to the logged-in user.
    @entry["user_id"] = current_user["id"]
  
    # Attach the uploaded file if one was provided.
    if params["uploaded_image"].present?
      @entry.uploaded_image.attach(params["uploaded_image"])
    end
  
    if @entry.save
      flash[:notice] = "Entry created successfully!"
      redirect_to "/places/#{@entry["place_id"]}"
    else
      flash[:notice] = "There was a problem creating your entry."
      render :new
    end
  end
  
  
end
