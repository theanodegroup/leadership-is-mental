class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:quill_update, :show_quill] # Require admin

  before_action :set_pages_vars, except: [:quill_update, :show_quill, :newsletter_signup]

  PAGE_PATHS_HASH = {
    about: { title: 'About'},
    what_you_get: { title: 'What you get'},
    leadership_jobs_page: { title: 'Leadership Jobs'},
    events: { title: 'Events'},
    news: { title: 'News'},
    free_ebook: { title: 'Free eBook'},
    blog: { title: 'Blog'},
    contact_us: { title: 'Contact Us'},
    newsletter_signup: { title: 'Newsletter Signup'},
    terms_of_use: { title: 'Terms of Use'},
    disclaimer: { title: 'Disclaimer'},
    legal: { title: 'Legal'},
  }

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
    @ebook = false
  end

  # Site Pages
  def about
  end

  def what_you_get
  end

  def leadership_jobs
    @leadership_jobs = LeadershipJob.all
  end

  def events
  end

  def free_ebook
    @title = "Free eBook" # Override
    @contact = Contact.new
    @ebook = true
  end

  def blog
    @posts = FacebookPost.all
  end

  def news
    @aricles = LeadershipArticle.all
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
