require_relative "./node.rb"
require "pry"

class BinaryTree

  attr_reader :root

  def initialize
    @count = 0
  end

  def add(title, score, current_node=nil, current_depth=0)
    current_node = current_node || @root
    current_depth = current_depth
    if @root.nil?
      @root = Node.new(title, score)
      @count += 1
      current_depth
    else
      current_depth += 1
      if score < current_node.score
        if current_node.left_link.nil?
          current_node.left_link = Node.new(title, score)
          @count += 1
          current_depth
        else
          add(title, score, current_node.left_link, current_depth)
        end
      else
        if current_node.right_link.nil?
          current_node.right_link = Node.new(title, score)
          @count += 1
          current_depth
        else
          add(title, score, current_node.right_link, current_depth)
        end
      end
    end
  end

  # def max
  #   current_node = current_node || @root
  #   until current_node.right_link.nil?
  #     current_node = current_node.right_link
  #   end
  #   current_node.score
  # end

  def max(current_node=nil)
    current_node = current_node || @root
    if current_node.right_link.nil?
      current_node.score
    else
      current_node = current_node.right_link
      max(current_node)
    end
  end

  # def min
  #   current_node = current_node || @root
  #   until current_node.left_link.nil?
  #     current_node = current_node.left_link
  #   end
  #   current_node.score
  # end

  def min(current_node=nil)
    current_node = current_node || @root
    if current_node.left_link.nil?
      current_node.score
    else
      current_node = current_node.left_link
      min(current_node)
    end
  end

  # def include?(score)
  #   current_node = current_node || @root
  #   until current_node == nil || current_node.score == score
  #     if score < current_node.score
  #       current_node = current_node.left_link
  #     else
  #       current_node = current_node.right_link
  #     end
  #   end
  #   !current_node.nil?
  # end

  def include?(score, current_node=nil)
    !depth_of(score).nil?
  end
  #   current_node = current_node || @root
  #   if current_node.nil? || current_node.score == score
  #     !current_node.nil?
  #   else
  #     if score < current_node.score
  #       current_node = current_node.left_link
  #     else
  #       current_node = current_node.right_link
  #     end
  #     if current_node.nil?
  #       return false
  #     else
  #       include?(score, current_node)
  #     end
  #   end
  # end

  def depth_of(score, current_node=nil, current_depth=0)
    current_node = current_node || @root
    if @root.nil?
      return nil
    end
    if current_node.nil? || current_node.score == score
      current_depth
    else
      if score < current_node.score
        current_node = current_node.left_link
        current_depth += 1
      else
        current_node = current_node.right_link
        current_depth +=1
      end
      if current_node.nil?
        current_depth = nil
      else
        depth_of(score, current_node, current_depth)
      end
    end

  end



  def sort(current_node=nil, movie_list=[])
    current_node = current_node || @root
    if !current_node.nil?
      if !current_node.left_link.nil?
        sort(current_node.left_link, movie_list)
      end
      movie_list << {current_node.title => current_node.score}
      if !current_node.right_link.nil?
        sort(current_node.right_link, movie_list)
      end
    else
      []
    end
    movie_list
  end

  def load(file)
    counter = 0
    contents = File.read(file)
    lines = contents.split("\n")
    lines.each do |line|
      movie = line.split(",") #array of strings
      unless include?(movie[0].to_i)
        add(movie[1], movie[0].to_i)
        counter += 1
      end
    end
    counter
  end

  def total_nodes
    @count
  end

  def count_node_and_children(current_node = nil)
    node_count = 0
    current_node = current_node || @root
    if !current_node.nil?
      if !current_node.left_link.nil?
        node_count += count_node_and_children(current_node.left_link)
      end
      if !current_node.right_link.nil?
        node_count += count_node_and_children(current_node.right_link)
      end
      node_count + 1
    end
  end

  def health(depth, current_node=nil, nodes_at_depth=[])
    current_node = current_node || @root
    if !current_node.nil?
      if depth_of(current_node.score) == depth
        count_nodes = count_node_and_children(current_node)
        nodes_at_depth << [current_node.score, count_nodes, ((count_nodes/total_nodes.to_f) * 100).to_i]
      else
        if !current_node.left_link.nil?
          health(depth, current_node.left_link, nodes_at_depth)
        end
        if !current_node.right_link.nil?
          health(depth, current_node.right_link, nodes_at_depth)
        end
      end
    end
    nodes_at_depth
  end
end
