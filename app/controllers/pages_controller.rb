class PagesController < ApplicationController
  before_action :set_pages_vars, except: [:quill_update, :show_quill, :newsletter_signup]

  before_action :authenticate_user!, only: [:quill_update, :show_quill] # Require admin

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

  # AJAX
  def newsletter_signup
  end

  # Site Pages
  def about
  end

  def what_you_get
  end

  def leadership_jobs
  end

  def events
  end

  def free_ebook
  end

  def blog
  end

  def contact
    @breadcrumb = :contact_us # Override
    @message = Message.new
  end

  def disclaimer
  end

  def legal
  end

  def terms_of_use
  end

  def sitemap
  end

private
  def set_pages_vars
    @page_name = action_name.to_sym
    @title = action_name.titleize
    @breadcrumb = action_name.to_sym
  end
end
