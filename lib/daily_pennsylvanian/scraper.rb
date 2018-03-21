class Scraper
  attr_accessor :sections, :articles, :subsections

  @@articles = []
  @@subsections = []
  @@sections = []

  def self.section_names
    @@sections[0..4].each_with_index do |section, index|
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
      s.articles = []
      unless s.name == "Multimedia" || s.name == "Projects"
        @@sections << s
      end
    end
  end

  def self.open_section(input)
    index = input - 1
    puts ""
    puts "..."
    puts "Welcome to #{@@sections[index].name}"
  end

  def self.access_url(input)
    index = input - 1
    if -1 < index && index < 3
      puts "Click the url:"
      puts "http://thedp.com#{@@sections[index].url}"
    else
      puts "Click the url:"
      puts @@sections[index].url
    end
  end

  def self.link(input)
    index = input - 1
    if -1 < index && index < 3
      "http://thedp.com#{@@sections[index].url}"
    else
      @@sections[index].url
    end
  end

  def self.scrape_article_details(input)
    Scraper.link(input)
    doc = Nokogiri::HTML(open(Scraper.link(input)))
    if Scraper.link(input) == "http://www.34st.com/"
      doc.search('nav.col-xs-10 a').each do |entry|
        ss = Subsection.new
        ss.name = entry.text
        ss.url = entry['href']
        @@subsections << ss
      end
    elsif Section.link(input) == "http://www.underthebutton.com/"
      doc.search('div.col-md-6.main article').each do |entry|
        a = Article.new
        a.title = entry.search('h2 a').text.strip
        a.timestamp = entry.search('span.publish').text.strip
        a.url = entry.search('h2 a[href]').map {|element| element["href"]}
        a.author = entry.search('span.author a').text.strip
        @@articles << a
      end
      Section.print_articles
    else
      doc.search('div.row div.col-md-8').each do |entry|
        a = Article.new
        a.title = entry.search('h3.standard-link a').text
        a.timestamp = entry.search('div.timestamp').text
        a.url = entry.search('h3.standard-link a[href]').map {|element| element["href"]}
        @@articles << a
      end
      Section.scrape_article_details_2
      Section.print_articles
    end
  end

  #need to figure out how to scrape each article's author and content (body text)
  def self.scrape_article_details_2
    @@articles.each do |article|
      link = article.url.join
      doc = Nokogiri::HTML(open(link))
      article.author = doc.search('div.article-metadata span.byline a').text
      article.content = doc.search('div.col-sm-12.col-md-8.article-container p').collect do |pgh|
        pgh.text.strip
      end
    end
  end

  def self.print_articles
    @@articles[1..-1].each_with_index do |article, index|
      indexplusone = index + 1
      puts "#{indexplusone}) #{article.title}
      By: #{article.author}
      Posted: #{article.timestamp}
      Link: #{article.url.join}"
    end
  end

  def self.print_article_content(input)
    index = input
    puts ""
    puts "..."
    puts @@articles[index].title
    puts @@articles[index].author
    puts @@articles[index].timestamp
    puts ""
    if @@articles[index].content != ""
      puts @@articles[index].content.join
    else
      puts @@articles[index].url
    end
  end

  def self.print_subsections
    @@subsections[0..5].each_with_index do |subsection, index|
      indexplusone = index + 1
      puts "#{indexplusone}) #{subsection.name}"
    end
  end
end
