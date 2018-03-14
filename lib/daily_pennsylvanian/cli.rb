class CLI
  def call
    welcome
    menu
  end

  def welcome
    puts "Welcome to the Daily Pennsylvanian!"
    puts ""
    puts "Which section piques your interest?"
    # scrape the website for the website names
  end

  def menu
    # list menu options: re-list sections, exit, select section
    puts "1) To select a Section of the newspaper, enter the Section number."
    puts "2) To see a list of the paper's Sections, enter 'list'."
    puts "3) To exit the program, enter 'exit'."
    # get input
    input = gets.strip
    # call methods (list_again, exit, open_section) depending on what the user inputs
    case input
    when "exit"
      exit_program
    when "list"
      list_sections
    else
      open_section
    end
  end

  def list_again
  end

  def exit
  end

  def open_section
  end
end
