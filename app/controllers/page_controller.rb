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

user_info = Twitter::Client.new.user("techcrunch")	
@techcrunch=user_info['followers_count']
startup= Startup.find_by_name("Gowalla")


			#result = JSON.parse(open("https://graph.facebook.com/" + startup.name).read)
			#likes = result["likes"]
			#date = Time.now
			#startup.update_attribute(:facebook_likes, likes)
end


end