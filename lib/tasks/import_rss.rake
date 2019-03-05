namespace :import_rss do
  desc "Import Jobs from RSS Feed(s)"
  task jobs: :environment do
    require 'rss'
    puts "Importing Jobs via RSS"

    feeds = [
      "https://au.indeed.com/rss?&as_ttl=leader+or+executive+or+director+or+chief+or+president&salary=%24150%2C000%2B&sort=date",
      "https://www.indeed.co.uk/rss?&as_ttl=leader+or+executive+or+director+or+chief+or+president&salary=%C2%A380,000&sort=date",
      "http://www.indeed.com/rss?q=Leader+executive+director+President+Chief&salary=%24100%2C000",
    ]

    feeds.each do |feed|
      puts "Importing jobs feed: #{feed}"
      rss = RSS::Parser.parse(feed, false)
      if rss.nil? || rss.items.nil? || rss.items.empty?
        puts "Nothing to import"
        next
      end

      rss.items.each do |item|
        begin
          LeadershipJob.find_or_create_by({
            title: item.title,
            link: item.link,
            pub_date: item.pubDate,
            description: item.description,
            source: item.source&.content,
            guid: item.guid&.content,
          })
        rescue StandardError => e
          puts "Error in Importing Job: #{e.class} => #{e.message}"
        end
      end
    end


    puts "Jobs import via RSS Completed"

    max_jobs = 500
    puts "Limiting number of leadership jobs to #{max_jobs}"
    jobs_to_save = LeadershipJob.all.reorder(pub_date: :desc).first(max_jobs)
    LeadershipJob.where.not(id: jobs_to_save).delete_all
    puts "There are now at most #{max_jobs} leadership jobs"
    puts "Number of leadership jobs: #{LeadershipJob.all.size}"
  end

# --------------------------------------------------------------------------------------------------

  desc "Import news from RSS Feed(s)"
  task news: :environment do
    require 'rss'
    puts "Importing News via RSS"

    feeds = [
      "#{ENV.fetch('HBR_FEED_URL')}",
    ]

    feeds.each do |feed|
      puts "Importing news feed: #{feed}"
      rss = RSS::Parser.parse(feed, false)
      if rss.nil? || rss.items.nil? || rss.items.empty?
        puts "Nothing to import"
        next
      end

      rss.items.each do |item|
        image = nil
        begin
          image = Nokogiri::HTML(item.content.content).css('img').first.attributes["src"].value
        rescue StandardError
        end

        begin
          # @todo: Use LeadershipNewsArticle instead
          LeadershipArticle.find_or_create_by({
            title: item.title&.content,
            pub_date: item.published&.content,
            source: item.links&.first&.href,
            guid: item.id&.content,
          })
        # rescue StandardError => e
        #   puts "Error in Importing Leadership News Article: #{e.class} => #{e.message}"
        end
      end
    end


    puts "News import via RSS Completed"

    max_news = 500
    puts "Limiting number of news articles to #{max_news}"
    articles_to_save = LeadershipArticle.all.reorder(pub_date: :desc).first(max_news)
    LeadershipArticle.where.not(id: articles_to_save).delete_all
    puts "There are now at most #{max_news} leadership articles"
    puts "Number of leadership articles: #{LeadershipArticle.all.size}"
  end

# --------------------------------------------------------------------------------------------------

  desc "Import posts from RSS Feed(s)"
  task posts: :environment do
    require 'rss'
    puts "Importing Posts via RSS"

    feeds = [
      "#{ENV.fetch('FACEBOOK_FEED_URL')}",
    ]

    feeds.each do |feed|
      puts "Importing posts feed: #{feed}"
      rss = RSS::Parser.parse(feed, false)
      if rss.nil? || rss.items.nil? || rss.items.empty?
        puts "Nothing to import"
        next
      end

      rss.items.each do |item|
        image = nil
        begin
          image = Nokogiri::HTML(item.description).css('img').first.attributes["src"].value
        rescue StandardError
        end

        begin
          # @todo: Use LeadershipNewsArticle instead
          FacebookPost.find_or_create_by({
            title: item.title,
            url: item.link,
            pub_date: item.pubDate,
            posted_by: item.dc_creator,
            guid: item.guid.content,
            image_url: image,
          })
        rescue StandardError => e
          puts "Error in Importing Blog Post: #{e.class} => #{e.message}"
        end
      end
    end

    puts "Posts import via RSS Completed"

    max_news = 500
    puts "Limiting number of posts articles to #{max_news}"
    jobs_to_save = FacebookPost.all.reorder(pub_date: :desc).first(max_news)
    FacebookPost.where.not(id: jobs_to_save).delete_all
    puts "There are now at most #{max_news} leadership posts"
    puts "Number of leadership posts: #{FacebookPost.all.size}"
  end
end
