
class Section
  attr_accessor :name, :url, :articles

  def initialize
    @@sections = []
  end

  def self.scrape_section_details
    link = "http://thedp.com"
    doc = Nokogiri::HTML(open(link))

    doc.search("div.homepage-header h4.section-nav").each do |entry|
      s = Section.new
      s.name = entry.search("a").text.each {|name| name.gsub!(/$/, ', ')}
      s.url = entry.search("a[href]").map{|element| element["href"]}
      @@sections << s
    end
    @@sections
  end

end
