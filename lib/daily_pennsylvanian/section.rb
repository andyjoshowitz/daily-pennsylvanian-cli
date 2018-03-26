
class Section
  attr_accessor :name, :url, :articles, :subsections

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

  def add_subsection(subsection)
    @subsections << subsection
    subsection.section = self
  end

  def subsections
    @subsections
  end

end
