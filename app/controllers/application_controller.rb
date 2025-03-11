class ApplicationController < ActionController::Base
  before_action :set_current_user
  helper_method :current_user

  def set_current_user
    # If there's a user id stored in the session, retrieve the corresponding user
    @current_user = User.find_by(id: session["user_id"]) if session["user_id"]
    # Optionally, log that this is running for every request
    puts "------------------ code before every request ------------------"
  end

  def current_user
    @current_user
  end
end
