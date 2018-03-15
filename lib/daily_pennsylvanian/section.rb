class Section
  attr_accessor :name, :url, :articles

  def initialize
    @articles = []
  end

  def self.section_scraper
    url = "http://thedp.com"
    doc = Nokogiri::HTML(open(url))

    sections = doc.search(".section-nav .header-section")
    sections.collect do |section|
      s = Section.new
      s.name = doc.search(".section-nav .header-section").text
      s.url = doc.search(".section-nav a.href").text.strip
    end
  end


  def add_article(article)
    @articles << article
  end
end
