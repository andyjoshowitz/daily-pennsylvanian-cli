
class Section
  attr_accessor :name, :url, :articles

  @@sections = []

  def initialize
    @articles = []
    @subsections = []
  end

  def self.add_section(s)
    @@sections << s
  end

  def self.sections
    @@sections
  end

  def add_article(article)
    @articles << article
    article.section = self
  end

  def articles
    @articles
  end

end
