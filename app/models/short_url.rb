class ShortUrl < ActiveRecord::Base
  serialize :response_data

  after_create :shorten

  CACHE_FIELDS = [:short_url, :long_url, :user_hash, :global_hash, :new_hash, :user_clicks,
                  :global_clicks, :aggregate_link, :clicks_by_minute]

  def shorten
    standardize_url_prefix
    begin
      puts "Fetching data from Bitly"

      client = Bitly::API::Client.new(token: ENV["BITLY_API_KEY"])
      bitlink = client.shorten(long_url: url)
      puts "Updating"
      update_data = {
        short_url: bitlink.try(:link),
        response_data: bitlink.inspect
      }
    rescue StandardError => e
      # Report and store the error
      puts "Shorten Error: #{e.class} #{e.message}"
      update_data = {
        response_data: {
          error: {
            class: e.class,
            message: e.message
          }
        }
      }
    end
      self.update(update_data)
  end

  def self.fetch(url, standardize)
    # Fetchs short url, shortening it if needed and returning the URL if there are any issues
    begin
      if standardize
        puts "Standardize URL: #{url}"
        url = ShortUrl.standardize_url(url)
        puts "=> #{url}"
      end
      short_url = ShortUrl.find_or_create_by!(url: url).try(:short_url)
      if short_url.nil? && Random.rand >= 0.95
        # 1 in 20 change of trying again
        short_url = ShortUrl.find_or_create_by!(url: url).try(:short_url)
      end
      return short_url
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

  def standardize_url_prefix
    update(url: "https://" + url) unless url.starts_with?('http')
  end

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
