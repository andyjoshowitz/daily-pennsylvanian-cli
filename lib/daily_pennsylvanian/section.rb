
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
  end

  def self.access_url(input)
    index = input - 1
    if -1 < index && index < 4 
      puts "Click the url:"
      puts "http://thedp.com#{@@sections[index].url}"
    else 
      puts "Click the url:"
      puts @@sections[index].url
    end
  end
end
end
