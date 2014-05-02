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
      user_posts << [node.text]
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
end


class Database
  attr_reader :user_posts
  def initialize(url)
    @user_posts = Scraper.scrape(url)
    make_database
  end

  def make_database

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

    # p @user_posts
    @user_posts.each do |foo, username|
      p foo
      p username
      # query = "insert into posts (comment, user) values (#{foo}, #{username});"

      DB_CONNECTION.execute(<<-SQL
        insert into posts
        (
          comment,
          user
        ) values ("#{foo}", "#{username}");
        SQL
      )
    end
    # insert_content
  end
end


# Database.new(url)
# db = Database.new("http://www.reddit.com/r/books/comments/24j4hp/what_are_the_most_obscure_english_books_in_your/")


# # Database.new.user_posts = Scraper.scrape("http://www.reddit.com/r/books/comments/24j4hp/what_are_the_most_obscure_english_books_in_your/")
# db.user_posts.each do |comment|
#   puts comment
#   puts '----------'
# end

Database.new("http://www.reddit.com/r/books/comments/24j4hp/what_are_the_most_obscure_english_books_in_your/")
p DB_CONNECTION.execute("select user from posts")
