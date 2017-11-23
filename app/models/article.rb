class Article < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :title_phrase, class_name: PhrasingPhrase
  belongs_to :summary_phrase, class_name: PhrasingPhrase
  belongs_to :body_phrase, class_name: PhrasingPhrase
  belongs_to :image_url_phrase, class_name: PhrasingPhrase


  default_scope { order(created_at: :desc) }

  scope :has_title, -> { joins(:title_phrase).where.not(phrasing_phrases: { value: [nil, ''] })    }
  scope :has_summary, -> { joins(:summary_phrase).where(phrasing_phrases: { value: [nil, ''] })    }
  scope :has_body, -> { joins(:body_phrase).where(phrasing_phrases: { value: [nil, ''] })    }

  scope :listable, -> { has_title.has_summary.has_body }

  after_create :phrase_it


  def listable?
      fields = [:title, :summary, :body]
      fields.any? { |field| !self.send(field).present? }
  end


  def phrase_it
    update_hash = {}

    fields = [:title, :summary, :body, :image_url]
    fields.each do |field|
      full_field_name = "#{field}_phrase_id".to_sym
      key = "article/#{id}/#{field}"
      phrase_id = PhrasingPhrase.find_or_create_by(locale: I18n.locale, key: key).id
      update_hash[full_field_name] = phrase_id
    end

    self.update(update_hash)
  end

  [:title, :summary, :body, :image_url].each do |field|
    define_method field do
      self.send("#{field}_phrase").value
    end

    define_method "#{field}_key" do
      self.send("#{field}_phrase").key
    end
  end

  def source
    article_path(self)
  end
end
