class Node

  attr_reader :title, :score
  attr_accessor :right_link, :left_link

  def initialize(title, score)
    @title = title
    @score = score
  end

end
