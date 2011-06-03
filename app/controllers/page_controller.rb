require "rubygems"
require "twitter"
require 'json'
require 'yajl'
require 'nokogiri'

class PageController < ApplicationController
  def home
    startups=Startup.all
#twitter search all 1500    
#  	sincedate= Time.now-2.day
#  	today= Time.now-1.month
#  	@todaydate= today.strftime("20%y%m")
#  	@since = sincedate.strftime("20%y-%m-%d")
#  	search = Twitter::Search.new.containing("gowalla").since_date(@since)
#	@tweets = search.fetch
#	next_tweets = search.fetch_next_page
#	while(next_tweets != nil) 
#       @tweets = @tweets + next_tweets
#       next_tweets = search.fetch_next_page
#    end
#	@tweetsnumber= 0
#	for tweets in @tweets
#		@tweetsnumber+=1
#	end	
#	@startupsnumber=0
#	startups.each do |startup|
#		@startupsnumber+=1
#	end
	

#		startups.each do |startup|
#			search = Twitter::Search.new			
#			twitterposts = search.containing(startup.name).since_date(@since)
#			@tweetsnumber = 0
#			for tweet in @tweets
#				@tweetsnumber +=1
#			end
#			startup.update_attribute(:tweets, @tweetsnumber)
#		end
	@result = JSON.parse(open("https://graph.facebook.com/presentbee").read)
	@likes = @result["likes"]
	
 	
 	doc = Nokogiri::HTML(open('http://www.google.com/cse?cx=partner-pub-4048050871544980%3Ao64kki9zarh&ie=ISO-8859-1&q=gowalla&sa=Search'))
	hey = doc.css('.g')
	hey.each do |link|
  		puts link.at_css('h2').text
  		puts link.at_css('span:nth-child(1)').text
	end
  		
# add employees from company
#	@crunchdata = JSON.parse(open("http://api.crunchbase.com/v/1/company/gowalla.js").read)
#	company_name = @crunchdata["name"]
#	description = @crunchdata["overview"]	
#	Startup.create(:name => company_name, :description => description)
	
#	@employees = @crunchdata["relationships"]
#	for employee in @employees
#		first_name = employee["person"]["first_name"]
#		last_name = employee["person"]["last_name"]
#		full_name = first_name + " " + last_name
#		position = employee["title"]
#		Employee.create(:name => full_name)
#		employee = Employee.find_by_name(full_name)
#		@company = Startup.find_by_name(company_name)
#		employee.employee_relationships.create!(:employee_id => employee.id, :company_id => @company.id)
#	end
	
#	@companyemployees=@company.employees
	
#	puts @crunchdata["homepage_url"]
#	puts @crunchdata["blog_url"]
#	puts @crunchdata["twitter_username"]
#	puts @crunchdata["number_of_employees"]
#	puts @crunchdata["foundedyear"]
#	puts @crunchdata["tag_list"]
#	puts @crunchdata["overview"]
#	puts @crunchdata["twitter_username"]
#	puts @crunchdata ["milestones"]

#user_info = Twitter::Client.new.user("techcrunch")	
#@techcrunch=user_info['followers_count']
#startup= Startup.find_by_name("Gowalla")


			#result = JSON.parse(open("https://graph.facebook.com/" + startup.name).read)
			#likes = result["likes"]
			#date = Time.now
			#startup.update_attribute(:facebook_likes, likes)
#mentions			
topsy = JSON.parse(open("http://otter.topsy.com/search.json?q=@foursquare&window=d").read)
puts topsy['response']['total']

#tweets about startup
tweets_about = JSON.parse(open("http://otter.topsy.com/search.json?q='foursquare'&window=d&type=tweet").read)
puts tweets_about['response']['total']

#topsy total search - update all and store day
topsy_search_total = JSON.parse(open("http://otter.topsy.com/searchcount.json?q='mapding'").read)
puts topsy_search_total['response']['a']
puts topsy_search_total['response']['d']

#topsy url tweets of a startups url- not working
#http://otter.topsy.com/stats.json?url=http://www.bragtaggs.com/

#description
#http://otter.topsy.com/urlinfo.json?url=http://mapding.com/

#experts gives name and twitter name
startup_experts = JSON.parse(open("http://otter.topsy.com/experts.json?q=mapding").read)
startup_experts = startup_experts['response']['list']
	startup_experts.each do |expert|
		puts expert['name']
		puts expert['nick']
		puts expert['influence_level']
		puts expert['url']

	end
startup_data = JSON.parse(open("http://api.crunchbase.com/v/1/company/gowalla.js").read)
			milestones = startup_data['milestones']
			for milestone in milestones
				milestone_description = milestone['description']
				milestone_source = milestone['source_url']
				milestone_date_year = milestone['stoned_year'].to_s
				milestone_date_month = milestone['stoned_month'].to_s
				milestone_date_day = milestone['stoned_day'].to_s
				milestone_date = milestone_date_day + "/" + milestone_date_month + "/" + milestone_date_year
				milestone_type = ""
				milestone_product = milestone_description =~ /launches|launched|launch|beta|alpha/i
				if milestone_product ==0
					milestone_type = "product_launch"
				end
				milestone_award = milestone_description =~ /award|awarded|awards|named|given|wins|won/i
				if milestone_award == 0 
					milestone_type = "award"
				end
				startup = Startup.first
				startup.milestones.create(:startup_id => startup.id, :type => milestone_type, :description => milestone_description, :source => milestone_source, :date => milestone_date)
			end



end


end