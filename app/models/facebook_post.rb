class FacebookPost < ActiveRecord::Base
  validates :guid, uniqueness: true

  paginates_per 10

  default_scope { order(pub_date: :desc) }

  def facebook_url
    # Converts odd URL from RssFetch to Facebook URL
    # from:
    #   https://www.facebook.com/#{a}_#{b}
    # to:
    #   https://www.facebook.com/#{fb_page}/#{b}

    cutoff_index = url.rindex('_')
    post_id = url[cutoff_index + 1..-1]
    "https://www.facebook.com/anodegroup/posts/#{post_id}"
  end
end
