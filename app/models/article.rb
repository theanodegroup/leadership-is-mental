class Article < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::SanitizeHelper

  belongs_to :title_phrase, class_name: PhrasingPhrase, :dependent => :delete
  belongs_to :summary_phrase, class_name: PhrasingPhrase, :dependent => :delete
  belongs_to :body_phrase, class_name: PhrasingPhrase, :dependent => :delete
  belongs_to :image_url_phrase, class_name: PhrasingPhrase, :dependent => :delete
  belongs_to :slug_phrase, class_name: PhrasingPhrase, :dependent => :delete

  default_scope { order(created_at: :desc) }

  scope :has_title, -> { joins(:title_phrase).where.not(phrasing_phrases: { value: [nil, ''] })    }
  scope :has_summary, -> { joins(:summary_phrase).where.not(phrasing_phrases: { value: [nil, ''] })    }
  scope :has_body, -> { joins(:body_phrase).where.not(phrasing_phrases: { value: [nil, ''] })    }

  scope :listable, -> { has_title.has_summary.has_body }

  SIZE_SETTING_PREFIX = 'quill/settings'

  # Due to how articles are handled, they are always created,
  #  so after_create should be equivilent to after_initalize
  after_create :phrase_it
  after_save :get_short_url

  def self.find_article(slug_or_id)
    article_by_id = Article.find_by(id: slug_or_id)
    return article_by_id if article_by_id.present?

    possible_slug = Article.new.auto_slug(slug_or_id)

    canidates = PhrasingPhrase.where(value: possible_slug)

    if canidates.present?
      canidates.find_each do |canidate|
        # Validate canidate
        key = canidate.key
        next unless key.ends_with?('/slug')
        next unless key.starts_with?('quill/article/')
        possible_id = key.gsub("/slug", "").gsub("quill/article/", "")
        next unless key == "quill/article/#{possible_id}/slug"
        next unless possible_id.to_i > 0

        # Determined the correct PhrasingPhrase, now convert to article
        article = Article.find_by(slug_phrase_id: canidate.id)

        article.try(:sluggify)
        return article unless article.nil?
      end
    end
    raise "No ID or Slug Found for |> #{slug_or_id.inspect} <|"
  end

  def get_short_url
    # @todo: This should update the existing one via checking for changes
    ShortUrl.fetch(source, true) if source.present?
  end

  def sluggify
    phrase = create_or_fetch_phrase(:slug)
    current_slug = clean_slug(slug)
    if current_slug.present?
      puts "A"
      phrase.update(value: clean_slug(slug))
    else
      phrase.update(value: auto_slug(current_slug))
    end
  end

  def listable?
    fields = [:title, :summary, :body]
    fields.any? { |field| !self.send(field).present? }
  end

  def phrase_it
    update_hash = {}

    fields = [:title, :summary, :body, :image_url, :slug]
    fields.each do |field|
      full_field_name = "#{field}_phrase_id".to_sym
      phrase_id = create_or_fetch_phrase(field).id
      update_hash[full_field_name] = phrase_id
    end


    self.update(update_hash)
  end

  [:title, :summary, :body, :image_url, :slug].each do |field|
    define_method field do
      phrase = self.send("#{field}_phrase")
      if phrase.present?
        if phrase.value.present? && phrase.value != phrase.key
          phrase.value
        else
          ''
        end
      else
      end
    end

    define_method "#{field}_phrase_name" do
      self.send("#{field}_phrase").key
    end
  end

  def clean_slug(value)
    strip_tags(value).to_s.parameterize
  end

  def auto_slug(value=nil)
    value = clean_slug(value)

    value = self.title unless value.present?
    # @todo, could add a devise token to make unique
    "#{clean_slug(value)}"
  end

  def source
    article_url(id: self.slug || self.id)
  end

  def create_or_fetch_phrase(field)
    key = "quill/article/#{id}/#{field}"
    PhrasingPhrase.find_or_create_by(locale: I18n.locale, key: key)
  end
end
