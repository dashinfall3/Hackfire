# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 24.hours do
	
	runner "Startup.update_startups", :environment => :development
	runner "Startup.update_facebook", :environment => :development
	runner "BlogEntry.update_from_feed('http://feeds.feedburner.com/mashable')", :environment => :development
	runner "BlogEntry.update_from_feed('http://feeds.feedburner.com/techcrunch')", :environment => :development
	runner "BlogEntry.update_from_feed('http://feeds.feedburner.com/techcocktail')", :environment => :development
	runner "BlogEntry.update_from_feed('http://feeds.feedburner.com/techcrunch')", :environment => :development
	runner "BlogEntry.update_from_feed('http://feeds.feedburner.com/flyovergeeks')", :environment => :development
	runner "BlogEntry.update_from_feed('http://feeds.feedburner.com/technori')", :environment => :development
	runner "Startup.update_compete", :environment => :development
	runner "BlogEntry.update_article_connections", :environment => :development
end

every 24.hours do
	runner "Startup.update_tweets", :environment => :development
end



