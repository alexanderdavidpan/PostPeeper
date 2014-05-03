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

  # def add_spoilers(*spoilers)
  #   @spoilers_array << spoilers
  #   @spoilers_array.flatten!
  # end

  def self.delete_spoilers(*spoilers)
    spoilers.each do |spoiler|
      @spoilers_array.delete(spoiler)
    end
  end

  #scan all comments and check for spoilers
  def self.scan_for_spoilers(posts)
    spoilers = BrowserUI.get_spoilers
    spoilers.each do |spoiler|
      posts.each do |username, comment|
        # spoilers.each do |spoiler|
        if !!(comment.include?("#{spoiler}")) #true or false depending on match found or not
          show_spoiler = BrowserUI.display_post
          if show_spoiler
            puts "-----"
            puts username  # move this, etal, to view
            puts comment
          end
        else
          puts "-----"
          puts username
          puts comment
        end
      end
    end
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

