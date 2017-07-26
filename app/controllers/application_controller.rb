class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :show_newsletter_signup, unless: -> { cookies[:shown_newsletter_signup] }

  def show_newsletter_signup
     cookies.permanent[:shown_newsletter_signup] = 1
     @show_newsletter_signup = true
  end
end
