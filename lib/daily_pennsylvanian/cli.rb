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
    puts ""
    puts "Menu"
    puts "1) To select a Section of the newspaper, enter the Section number."
    puts "2) To see a list of the paper's Sections again, enter 'list'."
    puts "3) To exit the program, enter 'exit'."
    # get input
    input = ""
    # call methods (list_again, exit, open_section) depending on what the user inputs
    while input != "exit"
      input = gets.strip
      case input
      when "exit"
        exit_program
        break
      when "list"
        list_sections
      else
        open_section
      end
    end
  end

  def list_sections

  end

  def exit_program
    puts "Thanks for visiting the DP. See you later!"
  end

  def open_section
  end
end
