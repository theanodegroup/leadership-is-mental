class PagesController < ApplicationController
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
    @message = Message.new
  end

  def newsletter_signup
  end

  def disclaimer
  end

  def legal
  end

  def terms_of_use
  end

  def sitemap
  end
end
