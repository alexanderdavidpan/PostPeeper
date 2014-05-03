# load 'controller.rb'

class BrowserUI
  attr_accessor :spoilers_array

  def self.welcome
    puts "Welcome to PostPeeper!"
  end

  def self.get_url
    puts "Please enter the URL of the reddit page you would like to view."
    url = gets.chomp
    url
  end

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

  def self.display_post_with_spoiler?
    puts "---SPOILER FOUND---"
    puts "What would you like to do? Skip or View?"
    spoiler_command = gets.chomp.downcase
    case spoiler_command
    when "skip"
      display_skipped_spoiler_message
    when "view"
      true
    else
      display_post_with_spoiler?
    end
  end

  def self.display_spoiled_post(username, comment)
    puts
    puts
    puts "*********************************************"
    puts "************* SPOILER!!!!!!!!! **************"
    self.display_post(username, comment)
    puts
    puts "************* SPOILER!!!!!!!!! **************"
    puts "*********************************************"
    puts
    press_enter_to_continue
  end

  def self.display_skipped_spoiler_message
    puts
    puts "<SPOILER SKIP>"
  end

  def self.press_enter_to_continue
    puts "press ENTER to continue"
    input = gets.chomp
    unless input == ""
      press_enter_to_continue
    end
    # unless input == "" press_enter_to_continue
  end

  def self.display_post(username, comment)
    puts
    puts "_" * username.length
    puts username
    puts "-" * username.length
    print comment
    puts
  end
end
