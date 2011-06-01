class Startup < ActiveRecord::Base
attr_accessible :tweets, :facebook_likes, :traffic_total, :name, :description, :industry, :blog_mentions, :twitter_username, :url, :blog_url, :blog_feed_url, :employees_number, :founded_year, :founded_month, :founded_day
	has_many :blog_entries
	has_many :facebook_likes
	has_many :twitter_tweets
	has_many :traffic_points
	
	has_many :employee_relationships, :foreign_key => "company_id",
									  :dependent => :destroy
									  
	has_many :employees, :through => :employee_relationships

# function checks crunchbase for any new startups, financial organizations or people	
	def self.add_new_startup_names
		startups = JSON.parse(open("http://api.crunchbase.com/v/1/companies.js").read)
		startups.each do |startup|
			startup_name = startup['name']
			if Startup.find_by_name(startup_name) != nil
			else
			Startup.create(:name => startup_name)
			end
		end
		financials = JSON.parse(open("http://api.crunchbase.com/v/1/financial-organizations.js").read)
		financials.each do |financial|
			financial_name = financial['name']
			if Financial.find_by_name(financial_name) != nil
			else
			Financial.create(:name => financial_name)
			end
		end
		employees = JSON.parse(open("http://api.crunchbase.com/v/1/people.js").read)
		employees.each do |employee|
			employee_name = employee['first_name'] + " " + employee['last_name']
			permalink = employee['permalink']
			if Employee.find_by_permalink(permalink) != nil
			else
			Employee.create(:name => employee_name, :permalink => permalink)
			end
		end
	end
	

# function updates startup crunchbase information for new and existing startups in database
	def self.update_startups
		startups= Startup.all
		startups.each do |startup|
			startup_data = JSON.parse(open("http://api.crunchbase.com/v/1/company/" + startup.name + ".js").read)
			startup_name = startup_data["name"]
			startup_description = startup_data["overview"]	
			startup_url = startup_data["homepage_url"]
			startup_url = startup_url.split("/")[2]
			blog_url = startup_data["blog_url"]
			blog_url = blog_url.split("//")[1]
			blog_feed_url = startup_data["blog_feed_url"]
			number_employees = startup_data["number_of_employees"]
			founded_year = startup_data["founded_year"]
			founded_month = startup_data["founded_month"]
			founded_day = startup_data["founded_day"]
			twitter_username = startup_data["twitter_username"]
			startup.update_attributes(:url => startup_url, :description => startup_description, :blog_url => blog_url, :blog_feed_url => blog_feed_url, :twitter_username => twitter_username, :employees_number => number_employees, :founded_year => founded_year, :founded_month => founded_month, :founded_day => founded_day)
			employees = startup_data["relationships"]
			for employee in employees
				first_name = employee["person"]["first_name"]
				last_name = employee["person"]["last_name"]
				full_name = first_name + " " + last_name
				permalink = employee["person"]["permalink"]
				position = employee["title"]
				Employee.create(:name => full_name, :permalink => permalink)
				employee = Employee.find_by_permalink(permalink)
				employee.employee_relationships.create!(:employee_id => employee.id, :company_id => startup.id, :position => position)
			end
		end
	end
	
	def self.update_tweets
		require "rubygems"
		require "twitter"
		require 'json'
		require 'yajl'
		sincedate= Time.now-2.day
		since = sincedate.strftime("20%y-%m-%d")
		startups= Startup.all
		startups.each do |startup|
#  			search = Twitter::Search.new.containing(startup.name).since_date(since)
#			tweets = search.fetch
#			next_tweets = search.fetch_next_page
#			while(next_tweets != nil) 
#	       		tweets = tweets + next_tweets
#        		next_tweets = search.fetch_next_page
#   			end
#			tweetsnumber= 0
#			for tweets in @tweets
#				tweetsnumber+=1
#			end	
#
#			search.clear
#			search = Twitter::Search.new.mentioning(startup.name).since_date(since)
#			mentions = search.fetch
#			next_mentions = search.fetch_next_page
#			while(next_mentions != nil) 
#        		mentions = mentions + next_mentions
#        		next_mentions = search.fetch_next_page
#   		end
#			mentions_number = 0
#			for mention in mentions
#				mentions_number +=1
#			end
			startup_info = Twitter::Client.new.user(startup.name)
			favorites = startup_info['favourites_count']
			followers_count = startup_info['followers_count']
			description = startup_info['notes']
			statuses_count = startup_info['statuses_count']
#			startup.update_attribute(:tweets, tweetsnumber)
			startup.twitter_tweets.create(:company_id => startup.id, :followers=> followers_count,:startup_tweets =>statuses_count, :date => Time.now)
		end
	end
	
	def self.update_facebook
		startups= Startup.all
		startups.each do |startup|
			result = JSON.parse(open("https://graph.facebook.com/" + startup.name).read)
			likes = result["likes"]
			date = Time.now
			startup.facebook_likes.create(:company_id => startup.id, :likes => likes, :date => Time.now)	
		end
	end
	
	def self.update_compete
		startups= Startup.all
		startups.each do |startup|
			compete= JSON.parse(open("http://apps.compete.com/sites/" + startup.url + "/trended/uv/?apikey=b7171acbc56de5ee782feeb846e7a9b5&latest=1").read)
 			uniquesmonth= compete["data"]["trends"]["uv"][0]["date"]
 			uniques= compete["data"]["trends"]["uv"][0]["value"]
 			startup.update_attribute(:traffic_total, uniques)
 			startup.traffic_points.create(:company_id =>startup.id, :unique_views => uniques)
 		end
 	end	
end
