class Scraper

  def website
    url = "http://thedp.com"
    @doc = Nokogiri::HTML(open(url))
  end

  def get_sections
    sections = self.website.css(".section-nav .header-section")
    sections.each do |section|
      puts "#{section.text.gsub(/\"/, "")}"
    end
  end
end
