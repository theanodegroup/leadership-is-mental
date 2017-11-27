class LeadershipArticle < ActiveRecord::Base
  validates :guid, uniqueness: true

  paginates_per 10

  default_scope { order(pub_date: :desc) }

  after_create :get_short_url

  def get_short_url
    ShortUrl.fetch(source, false) if source.present?
  end
end
