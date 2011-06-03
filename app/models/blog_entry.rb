class BlogEntry < ActiveRecord::Base
	has_many :blog_entry_relationships, :foreign_key => "blog_entry_id",
									  :dependent => :destroy
									  
	has_many :startups, :through => :blog_entry_relationships

	def self.update_from_feed(feed_url)
		feed = Feedzirra::Feed.fetch_and_parse(feed_url)
		feed.entries.each do |entry|
			unless exists? :title => entry.title
				create! (
					:title => entry.title,
					:summary => entry.summary,
					:link => entry.url,
					:date => entry.published,
					:guid => entry.id,
					:author => entry.author,
					:blog_name => feed.title)
			end
		end
	end
	
	#associate article with a given startup
	def self.update_article_connections
		startups = Startup.all
		startups.each do |startup|
			blog_entries = BlogEntry.all
			blog_entries.each do |blog_entry|
				if blog_entry.title.include? startup.name
				startup.blog_entry_relationships.create!(:blog_entry_id => blog_entry.id, :company_id => startup.id)
				end
			end	
		end		
	end	

end

 
