require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'sqlite3'


DB = "comments_database"
DB_CONNECTION = SQLite3::Database.new "#{DB}.db"

class Scraper

  def self.scrape(url)
    page = Nokogiri::HTML(open(url))
    user_posts = []
    page.css('div.md').each do |node|
      prepared_node = [(node.text).gsub(/"/, "'").strip]
      user_posts << prepared_node
    end

    user_posts.shift
    user_posts.pop

    counter = 0
    page.css('a.gray').each do |node|

      user_posts[counter] << node.text
      counter += 1
    end
    user_posts
  end

  def prepare(string)
    string.gsub(/"/, "'")
  end
end


class Database
  def self.get_posts(url)
    make_database(url)
    DB_CONNECTION.execute("select * from posts")
  end

  def self.make_database(url)
    user_posts = Scraper.scrape(url)

    # db_connection = SQLite3::Database.new "#{DB}.db"
    DB_CONNECTION.execute("drop table if exists posts")
    # I18n.enforce_available_locales = false

    DB_CONNECTION.execute(<<-SQL
      create table posts
      (
        user varchar(255),
        comment text
      );
      SQL
    )

    #Used prepare statement to protect against SQL injections
    insert_post = DB_CONNECTION.prepare(<<-SQL
      insert into posts
      (
        comment,
        user
      ) values (?, ?);
      SQL
    )

    user_posts.each do |comment, username|
      insert_post.execute(comment, username)
    end
  end
end


# Database.new(url)
# db = Database.new("http://www.reddit.com/r/books/comments/24j4hp/what_are_the_most_obscure_english_books_in_your/")


# # Database.new.user_posts = Scraper.scrape("http://www.reddit.com/r/books/comments/24j4hp/what_are_the_most_obscure_english_books_in_your/")
# db.user_posts.each do |comment|
#   puts comment
#   puts '----------'
# end

# Database.make_database("http://www.reddit.com/r/books/comments/24j4hp/what_are_the_most_obscure_english_books_in_your/")
# p DB_CONNECTION.execute("select * from posts")
# p .execute("select * from posts")
# p Database.get_posts("http://www.reddit.com/r/books/comments/24j4hp/what_are_the_most_obscure_english_books_in_your/")
