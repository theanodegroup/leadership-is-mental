class ShortUrl < ActiveRecord::Base
  serialize :response_data

  after_create :shorten

  CACHE_FIELDS = [:short_url, :long_url, :user_hash, :global_hash, :new_hash, :user_clicks,
                  :global_clicks, :aggregate_link, :clicks_by_minute]

  def shorten
    begin
      puts "Fetching data from Bitly"

      data = Bitly.client.shorten(ShortUrl.standardize_url(url))
      puts "Updating"
      self.update({
        short_url: data.try(:short_url),
        response_data: parse_response_data(data)
      })
    rescue StandardError => e
      puts "Shorten Error: #{e.class} #{e.message}"
    end
  end

  def self.fetch(url)
    # Fetchs short url, shortening it if needed and returning the URL if there are any issues
    begin
      short_url = ShortUrl.find_or_create_by!(url: url)

      return ShortUrl.find_or_create_by!(url: url).try(:short_url)
    rescue StandardError => e
      puts "Fetch Error: #{e.class} #{e.message}"
    end

    url
  end

  def self.standardize_url(url)
    # Standardize domain to avoid urls being domain specific in production
    if Rails.env.production?
      domain = 'http://www.leadershipismental.com'
    else
      domain = 'https://leadership-is-mental-myklclason.c9users.io'
    end
    domain + URI.parse(url).path
  end

  private

  def parse_response_data(response_data)
    puts "Parsing response"
    response_data_hash = {}
    CACHE_FIELDS.each do |field|
      puts "Parsing: #{field}"
      response_data_hash[field] = response_data.try(field)
    end
    if self.response_data && self.response_data[:updated]
      # Track the last 10 updates
      last_update = self.response_data[:updated].last(10)
    else
      last_update = []
    end
    response_data_hash[:updated] = last_update.push(Time.current)
    response_data_hash
  end
end
