
class Section
  attr_accessor :name, :url, :articles, :subsections

  @@sections = []
  @subsections = []
  @articles = []

  def self.add_section(s)
    @@sections << s
  end

  def self.sections
    @@sections
  end

  def self.section_names
    self.sections[0..4].each_with_index do |section, index|
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
        self.add_section(s)
      end
    end
  end

  def self.open_section(input)
    index = input - 1
    puts ""
    puts "..."
    puts "Welcome to #{self.sections[index].name}"
  end

  def self.access_url(input)
    index = input - 1
    if -1 < index && index < 3
      puts "Click the url:"
      puts "http://thedp.com#{self.sections[index].url}"
    else
      puts "Click the url:"
      puts self.sections[index].url
    end
  end

  def self.link(input)
    index = input - 1
    if -1 < index && index < 3
      "http://thedp.com#{self.sections[index].url}"
    else
      self.sections[index].url
    end
  end

  def self.scrape_article_details(input)
    self.link(input)
    doc = Nokogiri::HTML(open(self.link(input)))
    if self.link(input) == "http://www.34st.com/"
      doc.search('nav.col-xs-10 a').each do |entry|
        ss = Subsection.new
        ss.name = entry.text
        ss.url = entry['href']
        @subsections << ss
      end
    elsif self.link(input) == "http://www.underthebutton.com/"
      doc.search('div.col-md-6.main article').each do |entry|
        a = Article.new
        a.title = entry.search('h2 a').text.strip
        a.timestamp = entry.search('span.publish').text.strip
        a.url = entry.search('h2 a[href]').map {|element| element["href"]}
        a.author = entry.search('span.author a').text.strip
        @articles << a
      end
      self.print_articles
    else
      doc.search('div.row div.col-md-8').each do |entry|
        a = Article.new
        a.title = entry.search('h3.standard-link a').text
        a.timestamp = entry.search('div.timestamp').text
        a.url = entry.search('h3.standard-link a[href]').map {|element| element["href"]}
        @articles << a
      end
      self.scrape_article_details_2
      self.print_articles
    end
  end

  #need to figure out how to scrape each article's author and content (body text)
  def self.scrape_article_details_2
    @articles.each do |article|
      link = article.url.join
      doc = Nokogiri::HTML(open(link))
      article.author = doc.search('div.article-metadata span.byline a').text
      article.content = doc.search('div.col-sm-12.col-md-8.article-container p').collect do |pgh|
        pgh.text.strip
      end
    end
  end

  def self.print_articles
    @articles[1..-1].each_with_index do |article, index|
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
    puts @articles[index].title
    puts @articles[index].author
    puts @articles[index].timestamp
    puts ""
    if @articles[index].content != ""
      puts @articles[index].content.join
    else
      puts @articles[index].url
    end
  end

  def self.print_subsections
    @subsections[0..5].each_with_index do |subsection, index|
      indexplusone = index + 1
      puts "#{indexplusone}) #{subsection.name}"
    end
  end

  def self.access_ss_url(input)
    index = input - 1
    puts "Click the url:"
    puts "http://www.34st.com#{@subsections[index].url}"
  end

end
