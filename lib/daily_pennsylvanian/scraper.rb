class Scraper
  attr_accessor :section

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

    doc.search('div.row div.col-md-8').collect do |entry|
      #a = Article.new
      title = entry.search('h3.standard-link a').each do |title|
        puts title.text
      end
      #a.url = entry.attr("href").text.strip
      timestamp = entry.search('div.timestamp').each do |timestamp|
        puts timestamp.text
      end
      #@section.add_article(a)
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
