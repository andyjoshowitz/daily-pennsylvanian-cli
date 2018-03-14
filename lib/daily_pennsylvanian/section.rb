class Section
  attr_accessor :name
  attr_reader :subsections

  def initialize
    @subsections = []
  end

end
