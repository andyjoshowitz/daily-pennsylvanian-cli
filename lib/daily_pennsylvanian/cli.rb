class CLI

  def initialize

  end


  def call
    welcome
    main_menu
  end

  def welcome
    puts "Welcome to the Daily Pennsylvanian!"
    puts ""
    puts "Which section piques your interest?"
    puts ""
    Section.scrape
    Section.section_names
    #Scraper.get_sections
  end

  def main_menu
    # list menu options: re-list sections, exit, select section
    puts ""
    puts "Menu"
    puts "1) To select a Section of the newspaper, enter the Section name."
    puts "2) To see a list of the paper's Sections again, enter 'list'."
    puts "3) To exit the program, enter 'exit'."
    # get input
    input = ""
    # call methods (list_again, exit, open_section) depending on what the user inputs
    while input != "exit"
      input = gets.strip.downcase
      if input == "exit"
        exit_program
        break
      elsif input == "list"
        list_sections
      elsif input.to_i > 0
        open_section(input.to_i)
        break
      end
    end
  end

  def list_sections
    Section.section_names
  end

  def exit_program
    puts "Thanks for visiting the DP. See you later!"
  end

  def open_section(input)
    Section.open_section(input)
    section_menu
    user_input = ""
    while user_input != "exit"
      user_input = gets.strip.downcase
      if user_input == "exit"
        exit_program
        break
      elsif user_input.to_i == 1
        list_articles(input)
      elsif user_input.to_i == 2
        Section.access_url(input)
      elsif user_input.to_i == 3
        main_menu
      else
        puts "invalid entry, please try again:"
        Section.open_section(input)
      end
    end
  end

  def section_menu
    puts "1) To see a list of articles, enter 1."
    puts "2) To access the sections website, enter 2."
    puts "3) To return to the main menu, enter 3."
    puts "4) To exit the program, enter 'exit'."
  end

  def list_articles(input)
    puts "Articles:"
    Section.scrape_article_details(input)
    #Section.scrape_article_details_2
    #Section.print_articles
    #Section.print_articles
  end
end
