class Section
  attr_accessor :name, :subsections

  def initialize
    @subsections = []
    @@all_sections = []
  end

  def self.section_scraper
    doc = Nokogiri::HTML(open("http://thedp.com"))

    doc.search
    section = self.new
    section.name = doc.search("a.header-section").text.strip

    @@all_sections
  end

end
