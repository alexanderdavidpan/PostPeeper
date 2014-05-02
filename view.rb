# load 'controller.rb'

class BrowserUI
  attr_accessor :spoilers_array

  def self.get_spoilers
    @spoilers_array = []
    puts "="*50
    puts "What spoiler subjects would you like to avoid? (separate topics
      by semicolons"
    puts "-"*50
    a = gets.chomp.split("; ")
    @spoilers_array << a
    @spoilers_array.flatten!
  end

  def delete_spoilers
    puts "-"*50
    puts "What spoiler filter would you like to take out? (separate topics
      by semicolons"
    spoiler_to_be_deleted = gets.chomp.split("; ").downcase
    #spoiler_to_be_deleted.each {|spoiler| @spoilers.delete(spoiler)}
  end

  def self.display_post
    puts "---SPOILER FOUND---"
    puts "What would you like to do? Skip or View?"
    spoiler_command = gets.chomp.downcase
    case spoiler_command
    when "skip"
      return
    when "view"
      true
    end
  end

  def acquire_post
    DatabaseConnector.get_posts
  end

end

# view = BrowserUI.new
# p view.spoilers_array
# # @spoilers.each do |spoiler_subject|
# #   spoiler_subject =~ /()/
# # end
