class Startup < ActiveRecord::Base
attr_accessible :tweets, :facebook_likes, :traffic_total, :name, :description, :industry, :blog_mentions, :twitter_username, :url, :blog_url, :blog_feed_url, :employees_number, :founded_year, :founded_month, :founded_day
	has_many :facebook_likes
	has_many :twitter_tweets
	has_many :traffic_points
	has_many :milestones
	
	has_many :employee_relationships, :foreign_key => "company_id",
									  :dependent => :destroy
	has_many :persons, :through => :employee_relationships
	
	has_many :investments, :foreign_key => "company_id",
									  :dependent => :destroy
	has_many :financial_organizations, :through => :investments
	
	has_many :blog_entry_relationships, :foreign_key => "company_id",
									  :dependent => :destroy
									  
	has_many :blog_entries, :through => :blog_entry_relationships
	

# function checks crunchbase for any new startups, financial organizations or people	
	def self.add_new_startup_names
		startups = JSON.parse(open("http://api.crunchbase.com/v/1/companies.js").read)
		startups.each do |startup|
			startup_name = startup['name']
			startup_name.capitalize!
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
		persons = JSON.parse(open("http://api.crunchbase.com/v/1/people.js").read)
		persons.each do |person|
			person_first_name = person['first_name']
			person_last_name = person['last_name']
			person_name = person_first_name + " " + person_last_name
			permalink = person['permalink']
			if Person.find_by_permalink(permalink) != nil
			else
			Person.create(:name => person_name, :permalink => permalink)
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
				if Person.find_by_permalink(permalink) !=nil
				else
				Person.create(:name => full_name, :permalink => permalink)
				employee = Person.find_by_permalink(permalink)
				employee.employee_relationships.create!(:employee_id => employee.id, :company_id => startup.id, :position => position)
				end
			end
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
				startup.milestones.create(:startup_id => startup.id, :type => milestone_type, :description => milestone_description, :source => milestone_source, :date => milestone_date)
			end
			funding_rounds = startup_data['funding_rounds']
			for funding_round in funding_rounds
				amount_raised = funding_round['raised_amount']
				currency = funding_round['currency']
				#date = funding_round['funded_day'] + "/" + ['funded_month'] + "/" + ['funded_year']
				series = funding_round['round_code']
				investors = funding_round['investments']
				for investor in investors			
					if investor['financial_org'] != nil
						investor_name = investor['financial_org']['name']
						investor_permalink = investor['financial_org']['permalink']
						if FinancialOrganization.find_by_name(investor_name) ==nil
							FinancialOrganization.create(:name => investor_name, :investments_number => 1)
							financial_organization = FinancialOrganization.find_by_name(investor_name)
							financial_organization.investments.create!(:financial_organization_id => financial_organization.id, :company_id => startup.id, :amount => amount_raised, :series => series, :permalink => investor_permalink)
						else
							if Investment.find{|investment| investment.company_id == startup.id && investment.financial_organization_id == financial_organization.id && investment.series== series && investment.amount == amount_raised} == nil
								financial_organization = FinancialOrganization.find_by_name(investor_name)
								FinancialOrganization.update_counters financial_organization, :investments_number=> +1
								financial_organization.investments.create!(:financial_organization_id => financial_organization.id, :company_id => startup.id, :amount => amount_raised, :series => series)						
							else
							end
						end
					end
					if investor['person'] != nil
						investor_person_first_name = investor['person']['first_name']
						investor_person_last_name = investor['person']['last_name']
						investor_person_name = investor_person_first_name + " " + investor_person_last_name
						investor_person_permalink = investor['person']['permalink']
						if Person.find_by_permalink(investor_person_permalink) !=nil
							if Investment.find{|investment| investment.company_id == startup.id && investment.financial_organization_id == person.id && investment.series== series && investment.amount == amount_raised} == nil
								person = Person.find_by_permalink(investor_person_permalink)
								Person.update_counters person, :investments=> +1
								person.investments.create!(:financial_organization_id => person.id, :company_id => startup.id, :amount => amount_raised, :series => series)
							else
							end
						else
							Person.create(:name => investor_person_name, :permalink => investor_person_permalink, :investments => 1)
							person = Person.find_by_permalink(investor_person_permalink)
							person.investments.create!(:financial_organization_id => person.id, :company_id => startup.id, :amount => amount_raised, :series => series)
						end
					end
				end
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
			
			#mentions
			mentions = JSON.parse(open("http://otter.topsy.com/search.json?q=@" + startup.name + "&window=d").read)
			startup_mentions= mentions['response']['total']
			
			#tweets about startup
			tweets_about = JSON.parse(open("http://otter.topsy.com/search.json?q='"+ startup.name + "'&window=d&type=tweet").read)
			tweets_about_startup= tweets_about['response']['total']
			
			#topsy total search - update all and store day
			topsy_search_total = JSON.parse(open("http://otter.topsy.com/searchcount.json?q='" + startup.name + "'").read)
			startup_search_total = topsy_search_total['response']['a']
			startup_search_day = topsy_search_total['response']['d']
			
			startup.twitter_tweets.create(:company_id => startup.id, :followers=> followers_count,:startup_tweets =>statuses_count, :mentions => startup_mentions, :tweets_containing => tweets_about_startup, :social_search_total_mentions => startup_search_total, :date => Time.now)
			
			#experts gives name and twitter name
#			startup_experts = JSON.parse(open("http://otter.topsy.com/experts.json?q=mapding").read)
#			startup_experts = startup_experts['response']['list']
#			startup_experts.each do |expert|
#				expert_name = expert['name']
#				expert_twitter_nickname = expert['nick']
#				expert_influence_level = expert['influence_level']
#				expert_twitter_url = expert['url']
#				Employee.create(:name => expert_name, :permalink => permalink)
#				person = Person.find_by_name(expert_name)
#				person.expert_relationship.create(:company_id => startup.id, :person_id => person.id)
#			end
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
