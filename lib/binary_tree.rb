require_relative "./node.rb"

class BinaryTree

  attr_reader :root

  def initialize

  end

  def add(title, score, current_node=nil)
    current_node = current_node || @root
    if @root.nil?
      @root = Node.new(title, score)
    else
      if score < current_node.score
        if current_node.left_link.nil?
          current_node.left_link = Node.new(title, score)
        else
          add(title, score, current_node.left_link)
        end
      else
        if current_node.right_link.nil?
          current_node.right_link = Node.new(title, score)
        else
          add(title, score, current_node.right_link)
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



end
