class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :show_newsletter_signup, unless: -> { cookies[:shown_newsletter_signup] }

  def show_newsletter_signup
     cookies.permanent[:shown_newsletter_signup] = 1
     @show_newsletter_signup = true
  end

  # Quill
  def quill_update
    key = params[:key]
    value = params[:value]

    phrase = PhrasingPhrase.find_or_create_by(locale: I18n.locale, key: key)
    phrase.update(value: value)
    respond_to do |format|
      format.js { render 'editable/quill/update'}
    end
  end

  def show_quill
    @phrase = params[:phrase]
    @value = PhrasingPhrase.find_or_initialize_by(locale: I18n.locale, key: @phrase).value


    respond_to do |format|
      format.js { render 'editable/quill/edit'}
    end
  end
end
