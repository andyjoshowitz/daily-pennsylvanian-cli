class Scraper

  def self.get_sections
    url = "http://thedp.com"
    doc = Nokogiri::HTML(open(url))

    sections = doc.search(".section-nav .header-section")
    sections.each_with_index do |section, index|
      indexplusone = index + 1
      puts "#{indexplusone}) #{section.text.gsub(/\"/, "")}"
    end
  end

  def self.scrape_article_titles
    url = "http://thedp.com/section/news"
    doc = Nokogiri::HTML(open(url))

    #title = doc.search('div.col-md-8 h3.standard-link a')
    #title.each do |title|
      #puts title.text
    #end

    doc.search('div.col-md-8 h3.standard-link a').collect do |entry|
      a = Article.new
      a.title = entry.text
      a.url = entry.attr("href").text
    end
  end

  def self.scrape_article_timestamps
    url = "http://thedp.com/section/news"
    doc = Nokogiri::HTML(open(url))

    timestamp = doc.search('div.col-md-8 div.timestamp')
    timestamp.each do |timestamp|
      puts timestamp.text
    end
  end
end
