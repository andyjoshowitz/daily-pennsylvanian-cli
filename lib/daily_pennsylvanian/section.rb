
class Section
  attr_accessor :name, :url, :articles
  @@sections = []


  def self.section_names
    @@sections[0..6].each_with_index do |section, index|
      indexplusone = index + 1
      puts "#{indexplusone}) #{section.name}"
    end
  end

  def self.scrape
    link = "http://thedp.com"
    doc = Nokogiri::HTML(open(link))

    doc.search("div.homepage-header h4.section-nav a").collect do |entry|
      s = Section.new
      s.name = entry.text
      s.url = entry['href']
      @@sections << s
  end

  def self.open_section(input)
    index = input - 1
    puts "Welcome to #{@@sections[index].name}"
    #open_menu

  end

  def open_menu
    puts "1) To see a list of articles, enter 1."
    puts "2) To return to the main menu, enter 2."
  end
end
end
