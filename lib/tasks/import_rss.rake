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
          LeadershipJob.create({
            title: item.title,
            link: item.link,
            pub_date: item.pubDate,
            description: item.description,
            source: item.source.content,
            guid: item.guid.content,
          })
        rescue StandardError => e
          puts "Error in Importing Job: #{e.class} => #{e.message}"
        end
      end
    end


    puts "Jobs import via RSS Completed"

    max_jobs = 300
    puts "Limiting number of leadership jobs to #{max_jobs}"
    jobs_to_save = LeadershipJob.all.limit(max_jobs)
    LeadershipJob.where.not(id: jobs_to_save).delete_all
    puts "There are now at most #{max_jobs} leadership jobs"
    puts "Number of leadership jobs: #{LeadershipJob.all.size}"
  end


  desc "Import news from RSS Feed(s)"
  task news: :environment do
    require 'rss'
    puts "Importing Jobs via RSS"

    feeds = [
      "http://feeds.hbr.org/harvardbusiness",
    ]

    feeds.each do |feed|
      puts "Importing jobs feed: #{feed}"
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
          LeadershipArticle.create({
            title: item.title.content,
            content: item.content.content,
            pub_date: item.published.content,
            summary: item.summary.content,
            source: item.links.first.href,
            guid: item.id.content,
            image_url: image,
          })
        rescue StandardError => e
          puts "Error in Importing Job: #{e.class} => #{e.message}"
        end
      end
    end


    puts "Jobs import via RSS Completed"

    max_news = 300
    puts "Limiting number of news articles to #{max_news}"
    jobs_to_save = LeadershipArticle.all.limit(max_news)
    LeadershipArticle.where.not(id: jobs_to_save).delete_all
    puts "There are now at most #{max_news} leadership jobs"
    puts "Number of leadership jobs: #{LeadershipArticle.all.size}"
  end







end
