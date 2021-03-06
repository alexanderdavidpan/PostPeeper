

class BrowserUI
  attr_accessor :spoilers_array

  def self.welcome
    puts "Welcome to PostPeeper!"
  end

  def self.get_url
    puts "Please enter the URL of the reddit page you would like to view."
    print "> "
    url = gets.chomp
    url
  end

  def self.get_spoilers
    @spoilers_array = []
    puts "="*50
    puts "What spoiler subjects would you like to avoid?"
    puts "Separate topics by semicolons."
    puts "-"*50
    print "> "
    a = gets.chomp.split("; ")
    @spoilers_array << a
    @spoilers_array.flatten!
  end

  def self.delete_spoilers
    puts "-"*50
    puts "What spoiler filter would you like to take out?"
    list_spoilers
    print "> "
    spoiler_to_be_deleted = gets.chomp.downcase.split("; ")
    spoiler_to_be_deleted.each {|spoiler| @spoilers_array.delete(spoiler)}
  end

  def self.list_spoilers
    @spoilers_array.each do |spoiler|
      puts " - #{spoiler}"
    end
  end

  def self.display_post_with_spoiler?
    puts "---SPOILER FOUND---"
    puts "> What would you like to do? Skip or View?"
    spoiler_command = gets.chomp.downcase
    case spoiler_command
    when "skip", "s"
      display_skipped_spoiler_message
    when "view", "v"
      true
    else
      display_post_with_spoiler?
    end
  end

  def self.display_spoiled_post(username, comment)
    puts
    puts
    puts "=============================================="
    puts "************* SPOILER!!!!!!!!! ***************"
    puts "=============================================="
    self.display_post(username, comment)
    puts
    puts "=============================================="
    puts "************* SPOILER!!!!!!!!! ***************"
    puts "=============================================="
    puts
    press_enter_to_continue
  end

  def self.display_skipped_spoiler_message
    delete_previous_lines(2)
    puts "<SPOILER SKIPPED>"
    puts
  end

  def self.press_enter_to_continue
    puts
    print "> press ENTER to continue or type DELETE to delete spoiler topic(s): "
    puts
    print "> "
    input = gets.chomp.downcase.strip
    if input == "delete" || input == "d"
      delete_spoilers
    elsif input == ""
      delete_previous_lines(1)
    else
      press_enter_to_continue
    end
  end

  def self.display_post(username, comment)
    puts
    puts "_" * username.length
    puts username
    puts "-" * username.length
    print comment
    puts
  end

  def self.delete_previous_lines(num)
    print "\r" + "\e[A\e[K" * num
  end
end
