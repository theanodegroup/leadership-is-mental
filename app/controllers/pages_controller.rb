class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:quill_update, :show_quill, :settings] # Require admin

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
    privacy_policy: { title: '"Privacy Policy"'},
    disclaimer: { title: 'Disclaimer'},
    legal: { title: 'Legal'},
    courses: { title: 'Courses'},
  }

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

  def courses
    begin
      @vhx = Vhx.setup({ api_key: ENV['VHX_API_KEY'] })
      @products = Vhx::Product.list
    rescue Vhx::VhxError
      # Handle error
      @products = []
    end
  end

  def free_ebook
    @title = "Free eBook" # Override
    @contact = Contact.new
    @ebook = true
  end

  def blog
    @posts = FacebookPost.all
  end

  def articles
    @articles = Article.all.listable
  end

  def news
    @leadership_articles = LeadershipArticle.all
  end

  def contact
    @breadcrumb = :contact_us # Override
    @message = Message.new
  end

  def disclaimer
  end

  def legal
  end

  def privacy_policy
  end

  def sitemap
  end

  def settings
  end

  def videos_faq
  end

private
  def set_pages_vars
    @page_name = action_name.to_sym
    @title = action_name.titleize
    @breadcrumb = action_name.to_sym
  end
end
