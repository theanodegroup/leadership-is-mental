namespace :import_rss do
  desc "Import Jobs from RSS Feed(s)"
  task jobs: :environment do
    require 'rss'
    puts "Importing Jobs via RSS"

    rss = RSS::Parser.parse('http://www.indeed.ca/rss?q=millwright&l=Toronto%2C+ON&sort=date', false)
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

    puts "Jobs import via RSS Completed"

    max_jobs = 100
    puts "Limiting number of leadership jobs to #{max_jobs}"
    jobs_to_save = LeadershipJob.all.limit(max_jobs)
    LeadershipJob.where.not(id: jobs_to_save).delete_all
    puts "There are now at most #{max_jobs} leadership jobs"
  end
end
