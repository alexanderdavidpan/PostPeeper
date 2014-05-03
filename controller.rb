load 'view.rb'
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
  def self.scan_for_spoilers
    spoilers = BrowserUI.get_spoilers
    # BrowserUI.get_spoilers.each do |spoiler|
      DatabaseConnector.get_posts.each do |comment|
        spoilers.each do |spoiler|
        if !!(comment[0].include?("#{spoiler}")) #true or false depending on match found or not
          show_spoiler = BrowserUI.display_post
          puts comment[0] if show_spoiler
        else
          puts comment[0]
        end
      end
    end
  end

end

class DatabaseConnector
  attr_accessor :comments
  def self.get_posts
    @comments = DB1.execute("SELECT * FROM posts")
  end
end

class Program
  def self.run
    DatabaseConnector.get_posts
    # BrowserUI.get_spoilers
    Controller.scan_for_spoilers
    # # Controller.
  end
end


Program.run

# comments = DatabaseConnector.get_posts

# Controller.scan_for_spoilers(comments)


# controller = Controller.new
# p controller.add_spoilers("NBA", "Breaking Bad", "Game of Thrones")



# p controller.delete_spoilers("NBA", "Game of Thrones")

