require "minitest/autorun"
require "minitest/pride"
require "../lib/node.rb"

class NodeTest < MiniTest::Test
  def test_node_has_title_and_score
    title = "Pizza"
    score = 70
    node = Node.new(title, score)

    #assert_equal expected, actual
    assert_equal title, node.title
    assert_equal score, node.score
  end

  # def test_node_holds_different_data
  #   data = "Ham Shank"
  #   node = Node.new(data)
  #
  #   assert_equal data, node.data
  # end
  #
   def test_node_has_no_right_or_left_link_by_default
     title = "Ham shank"
     score = 50
     node = Node.new(title, score)

     assert_equal nil, node.right_link
     assert_equal nil, node.left_link
   end
  #
   def test_node_does_have_right_child
     node_1 = Node.new("Ham", 2)
     node_2 = Node.new("Turkey", 8)

     node_1.right_link = node_2

     assert_equal node_2, node_1.right_link
     assert_equal "Turkey", node_1.right_link.title

   end

   def test_can_does_have_left_child
     node = Node.new("Ham", 2)
     child_node = Node.new("Pastrami", 1)

     node.left_link = child_node

     assert_equal child_node, node.left_link
     assert_equal "Pastrami", node.left_link.title

   end


end
