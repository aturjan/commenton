class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  @@usernotsubj  = false

  def user_is_false
    @@usernotsubj = false 
  end

  def user_is_true
    @@usernotsubj = true
  end

  def self.usernotsubject
    @@usernotsubj
  end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end