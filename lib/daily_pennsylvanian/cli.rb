class CLI

  def call
    welcome
    main_menu
  end

  def welcome
    puts "Welcome to the Daily Pennsylvanian!"
    Scraper.scrape_sections
  end

  def main_menu
    puts ""
    main_menu_options

    input = ""
    while input != "exit"
      input = gets.strip.downcase
      if input == "exit"
        exit_program
        break
      elsif input == "list"
        list_sections
      elsif input.to_i > 0 && input.to_i < 6
        open_section(input.to_i)
        break
      else
        invalid_entry
        main_menu
        break
      end
    end
  end

  def main_menu_options
    puts "Which section piques your interest?"
    section_names
    puts ""
    puts "Main Menu"
    puts "1) To select a Section of the newspaper, enter the Section number."
    puts "2) To see a list of the paper's Sections again, enter 'list'."
    puts "3) To exit the program, enter 'exit'."
  end

  def list_sections
    puts ""
    puts "..."
    puts "Sections"
    section_names
    puts ""
    puts "To select a section, enter its number:"
  end

  def exit_program
    puts ""
    puts "Thanks for visiting the DP. See you later!"
    puts ""
  end

  def invalid_entry
    puts ""
    puts "invalid entry, please try again:"
  end

  def open_section(input)
    section_menu(input)
    user_input = ""
    while user_input != "exit"
      user_input = gets.strip.downcase
      if user_input == "exit"
        exit_program
        break
      elsif user_input.to_i == 1
        if input == 4
          open_subsections(input)
        else
          list_articles(input)
          article_content(input)
        end
        break
      elsif user_input.to_i == 2
        get_url(input)
      elsif user_input.to_i == 3 ||user_input == "menu"
        main_menu
        break
      else
        invalid_entry
        open_section(input)
        section_menu(input)
        break
      end
    end
  end


  def section_menu(input)
    index = input - 1
    puts ""
    puts "..."
    puts "Welcome to #{Section.sections[index].name}"
    puts ""
    puts "Section Menu"
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

  def get_url(input)
    puts ""
    puts "..."
    index = input - 1
    if -1 < index && index < 3
      puts "Click the url:"
      puts "http://thedp.com#{Section.sections[index].url}"
    else
      puts "Click the url:"
      puts Section.sections[index].url
    end
    puts ""
    puts "To exit the program, enter 'exit'."
    puts "To return to the menu, enter 'menu'."
  end

  def list_articles(input)
    puts ""
    puts "Loading articles..."
    puts ""
    Scraper.scrape_article_details(input)
    puts "Articles:"
    Section.sections[input-1].articles[1..-1].each_with_index do |article, index|
      indexplusone = index + 1
      puts "#{indexplusone}) #{article.title}"
      puts "    By: #{article.author} "
      puts "    Posted: #{article.timestamp}"
      puts "    Link: #{article.url.join}"
    end
  end

  def article_content(input)
    section = Section.sections[input-1]
    articles_menu
    number = ""
    while number != "exit"
      number = gets.strip.downcase
      if number == "exit"
        exit_program
        break
      elsif number.to_i > 0
        item = number.to_i
        article = section.articles[item]
        print_article_content(article)
        puts ""
        puts "To return to the articles menu, enter 'back'."
        puts "To exit the program, enter 'exit'."
      elsif number == "back"
        article_content(input)
        break
      elsif number == "menu"
        main_menu
        break
      else
        invalid_entry
        articles_menu
      end
    end
  end

  def articles_menu
    puts ""
    puts "Articles Menu:"
    puts "1) To read an article, enter its number."
    puts "2) To exit the program, enter 'exit'."
    puts "3) To return to the Main Menu, enter 'menu'."
  end

  def print_article_content(article)
    puts ""
    puts "..."
    puts article.title
    puts article.author
    puts article.timestamp
    puts ""
    if article.content != ""
      puts article.content[0..-2].join
    else
      puts article.url
    end
  end

  def open_subsections(input)
    list_subsections(input)
    subsection_menu
    ss_input = ""
    while ss_input != "exit"
      ss_input = gets.strip.downcase
      if ss_input == "exit"
        exit_program
        break
      elsif ss_input.to_i > 0
        index = ss_input.to_i - 1
        # I created a new variable here to help smooth things over in my access_ss_url method
        path = Section.sections[input-1].subsections[index]
        access_ss_url(path)
        puts ""
        puts "To exit the program, enter 'exit'."
        puts "To return to the subsection menu, enter 'back'."
      elsif ss_input == 'back'
        open_subsections(input)
        break
      elsif ss_input == "menu"
        main_menu
        break
      else
        invalid_entry
        subsection_menu
      end
    end
  end

  def subsection_menu
    puts ""
    puts "Subsection Menu:"
    puts "1) To access a subsection's url, enter its number."
    puts "2) To return to the Main Menu, enter 'menu'."
    puts "3) To exit the program, enter 'exit'."
  end

  def list_subsections(input)
    puts ""
    puts "..."
    puts "Subsections:"
    Scraper.scrape_article_details(4)
    Section.sections[input-1].subsections[0..5].each_with_index do |subsection, index|
      indexplusone = index + 1
      puts "#{indexplusone}) #{subsection.name}"
    end
  end

  #fixed method!
  def access_ss_url(path)
    puts "Click the url:"
    puts "http://www.34st.com#{path.url}"
  end

  def section_names
    Section.sections[0..4].each_with_index do |section, index|
      indexplusone = index + 1
      puts "#{indexplusone}) #{section.name}"
    end
  end

end
