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
    Section.scrape
  end

  def main_menu
    # list menu options: re-list sections, exit, select section
    puts "Which section piques your interest?"
    Section.section_names
    puts ""
    puts "Main Menu"
    puts "1) To select a Section of the newspaper, enter the Section number."
    puts "2) To see a list of the paper's Sections again, enter 'list'."
    puts "3) To exit the program, enter 'exit'."

    input = ""

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
    puts ""
    puts "..."
    puts "Sections"
    Section.section_names
    puts ""
    puts "To select a section, enter its number:"
  end

  def exit_program
    puts ""
    puts "Thanks for visiting the DP. See you later!"
    puts ""
  end

  def open_section(input)
    Section.open_section(input)
    section_menu(input)
    user_input = ""
    while user_input != "exit"
      user_input = gets.strip.downcase
      if user_input == "exit"
        exit_program
        break
      elsif user_input.to_i == 1
        if input == 4
          list_subsections
        else
          list_articles(input)
          article_content
        end
        break
      elsif user_input.to_i == 2
        puts ""
        puts "..."
        Section.access_url(input)
        puts ""
        puts "To exit the program, enter 'exit'."
      elsif user_input.to_i == 3
        main_menu
        break
      else
        puts "invalid entry, please try again:"
        Section.open_section(input)
        section_menu(input)
      end
    end
  end

  def section_menu (input)
    if input == 4
      puts "1) To see a list of subsections, enter 1."
      puts "2) To access the sections website, enter 2."
      puts "3) To return to the main menu, enter 3."
      puts "4) To exit the program, enter 'exit'."
    else
      puts "1) To see a list of articles, enter 1."
      puts "2) To access the sections website, enter 2."
      puts "3) To return to the main menu, enter 3."
      puts "4) To exit the program, enter 'exit'."
    end
  end

  def list_articles(input)
    puts ""
    puts "Loading articles..."
    puts ""
    puts "Articles:"
    Section.scrape_article_details(input)
  end

  def articles_menu
    puts "Menu:"
    puts "1) To read an article, enter its number."
    puts "2) To exit the program, enter 'exit'."
    puts "3) To return to the Main Menu, enter 'menu'."
  end

  def article_content
    articles_menu
    number = ""
    while number != "exit"
      number = gets.strip.downcase
      if number == "exit"
        exit_program
        break
      elsif number.to_i > 0
        input = number.to_i
        Section.print_article_content(input)
        puts ""
        puts "To return to the articles menu, enter 'back'."
      elsif number == "back"
        article_content
        break
      elsif number == "menu"
        main_menu
        break
      else
        puts "invalid entry, please try again:"
        articles_menu
      end
    end
  end

  def list_subsections
    puts ""
    puts "..."
    puts "Subsections:"
    Section.print_subsections
    subsection_menu
  end

  def subsection_menu
    puts ""
    puts "Subsection Menu:"
    puts "To access a subsection's url, enter its number."
    puts "To return to the Main Menu, enter 'menu'."
    puts "To exit the program, enter 'exit'."
  end
end
