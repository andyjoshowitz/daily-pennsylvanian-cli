
class Section
  attr_accessor :name, :url, :articles

  def initialize
    @@sections = []
  end


  def self.section_names
    self.scrape
    @@sections.each {|section| puts section.name}
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
end
end
