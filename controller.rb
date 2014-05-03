load 'view.rb'
load 'database.rb'
require 'rubygems'
require 'active_record'
require 'sqlite3'


DB1 = SQLite3::Database.new('posts.db')


class Controller
  attr_accessor :spoilers_array

  def initialize
    @spoilers_array = BrowserUI.spoilers_array
  end

  def self.delete_spoilers(*spoilers)
    spoilers.each do |spoiler|
      @spoilers_array.delete(spoiler)
    end
  end

  def self.scan_for_spoilers(posts)
    spoilers = BrowserUI.get_spoilers
    posts.each do |username, comment|
      if spoiler_present?(comment, spoilers)
        if BrowserUI.display_post_with_spoiler?
          BrowserUI.display_post(username, comment)
        end
      else
        BrowserUI.display_post(username, comment)
      end #if spoiler_present?
    end #posts.each do
  end #self.scan_for_spilers

  def self.spoiler_present?(comment, spoilers)
    spoilers.each { |spoiler| return true if !!(comment.include?("#{spoiler}")) }
    false
  end
end

class DatabaseConnector
  attr_accessor :comments
  def self.get_posts(url)
    # @comments = DB1.execute("SELECT * FROM posts")
    @comments = Database.get_posts(url)  #2D array, confirmed
  end
end

class Program
  def self.run
    BrowserUI.welcome
    url = BrowserUI.get_url
    posts = DatabaseConnector.get_posts(url)
    Controller.scan_for_spoilers(posts)
    # # Controller.
  end
end


Program.run

# comments = DatabaseConnector.get_posts

# Controller.scan_for_spoilers(comments)


# controller = Controller.new
# p controller.add_spoilers("NBA", "Breaking Bad", "Game of Thrones")



# p controller.delete_spoilers("NBA", "Game of Thrones")

