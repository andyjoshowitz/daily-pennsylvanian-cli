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

  def self.scrape_article_details
    url = "http://thedp.com/section/news"
    doc = Nokogiri::HTML(open(url))

    #title = doc.search('div.col-md-8 h3.standard-link a')
    #title.each do |title|
      #puts title.text
    #end

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

  def self.scrape_article_details
    url = "http://thedp.com/section/news"
    doc = Nokogiri::HTML(open(url))

    #title = doc.search('div.col-md-8 h3.standard-link a')
    #title.each do |title|
      #puts title.text
    #end

    doc.search('div.row div.col-md-8').each do |entry|
      a = Article.new
      a.title = entry.search('h3.standard-link a').text
      #a.url = entry.attr("href").text.strip
      a.timestamp = entry.search('div.timestamp').each do |timestamp|
        puts timestamp.text
      end
      #@section.add_article(a)
      a.url = entry.search('h3.standard-link a').each do |link|
        puts link['href']
      end
      Section.add_article(a)
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

  def self.list_articles
    url = "http://thedp.com/section/news"
    doc = Nokogiri::HTML(open(url))

    title = doc.search('div.col-md-8 h3.standard-link a')
    title.each_with_index do |title, index|
      indexplusone = index + 1
      puts "#{indexplusone}) #{title.text}"
    end
  end

  def self.scrape_article_blurb
    url = "http://thedp.com/section/news"
    doc = Nokogiri::HTML(open(url))

    blurb = doc.search('div.row div.col-md-8').each do |blurb|
      puts blurb.text.strip
    end
  end
end
