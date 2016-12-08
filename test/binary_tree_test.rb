require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/binary_tree.rb"

class BinaryTreeTest < MiniTest::Test

  def test_tree_adds_root_node
    tree = BinaryTree.new
    tree.add("Mission Impossible", 1)
    assert_equal "Mission Impossible", tree.root.title
    assert_equal 1, tree.root.score
  end

  def test_tree_adds_right_child_node
    tree = BinaryTree.new
    tree.add("Mission Impossible", 30)
    tree.add("Beetlejuice", 70)
    node = tree.root.right_link
    assert_equal "Beetlejuice", node.title
    assert_equal 70, node.score
  end

  def test_tree_adds_left_child_node
    tree = BinaryTree.new
    tree.add("Mission Impossible", 30)
    tree.add("Top Gun", 10)
    node = tree.root.left_link
    assert_equal "Top Gun", node.title
    assert_equal 10, node.score
  end

  def test_tree_adds_left_right_grandchild_node
    tree = BinaryTree.new
    tree.add("Mission Impossible", 30)
    tree.add("Top Gun", 10)
    tree.add("Mask", 20)
    node = tree.root.left_link.right_link
    assert_equal "Mask", node.title
    assert_equal 20, node.score
  end

  def test_tree_adds_left_right_great_grandchild_node
    tree = BinaryTree.new
    tree.add("Mission Impossible", 30)
    tree.add("Top Gun", 10)
    tree.add("Mask", 20)
    tree.add("Darkman", 25)
    node = tree.root.left_link.right_link.right_link
    assert_equal "Darkman", node.title
    assert_equal 25, node.score
  end

  def test_tree_add_returns_depth
    tree = BinaryTree.new
    assert_equal 0, tree.add("Mission Impossible", 30)
    assert_equal 1, tree.add("Top Gun", 10)
    assert_equal 2, tree.add("Mask", 20)
    assert_equal 3, tree.add("Darkman", 25)
    assert_equal 1, tree.add("BOOM!", 40)
  end

  def test_tree_goes_to_right_for_max
    tree = BinaryTree.new
    tree.add("Mission Impossible", 30)
    tree.add("Dumb and Dumber", 10)
    tree.add("Beetlejuice", 40)
    tree.add("Batman Returns", 25)
    tree.add("Darkman", 80)

    assert_equal 80, tree.max
  end

  def test_tree_goes_to_left_for_min
    tree = BinaryTree.new
    tree.add("Mission Impossible", 30)
    tree.add("Dumb and Dumber", 10)
    tree.add("Beetlejuice", 40)
    tree.add("Batman Returns", 25)
    tree.add("Darkman", 80)

    assert_equal 10, tree.min
  end

  def test_tree_includes_score
    tree = BinaryTree.new
    tree.add("Mission Impossible", 30)
    tree.add("Dumb and Dumber", 10)
    tree.add("Beetlejuice", 40)
    tree.add("Batman Returns", 25)
    tree.add("Darkman", 80)

    assert_equal true, tree.include?(10)
  end

  def test_tree_does_not_include_score
    tree = BinaryTree.new
    tree.add("Mission Impossible", 30)
    tree.add("Dumb and Dumber", 10)
    tree.add("Beetlejuice", 40)
    tree.add("Batman Returns", 25)
    tree.add("Darkman", 80)

    assert_equal false, tree.include?(5)
  end

  def test_tree_finds_depth_of_node
    tree = BinaryTree.new
    tree.add("Mission Impossible", 30)
    tree.add("Dumb and Dumber", 10)
    tree.add("Beetlejuice", 40)
    tree.add("Batman Returns", 25)
    tree.add("Darkman", 80)

    assert_equal 2, tree.depth_of(25)
  end

  def test_tree_returns_nil_for_missing_score
    tree = BinaryTree.new
    tree.add("Mission Impossible", 30)
    tree.add("Dumb and Dumber", 10)
    tree.add("Beetlejuice", 40)
    tree.add("Batman Returns", 25)
    tree.add("Darkman", 80)

    assert_nil tree.depth_of(7)
  end

  def test_tree_returns_array_of_hashes
    tree = BinaryTree.new
    tree.add("Mission Impossible", 30)
    tree.add("Dumb and Dumber", 10)
    tree.add("Beetlejuice", 40)
    tree.add("Batman Returns", 25)
    tree.add("Darkman", 80)


    assert_equal Array, tree.sort.class
    #assert_equal Hash, movie_list[0].class
  end

  def test_tree_sorts_hash
    tree = BinaryTree.new
    tree.add("Mission Impossible", 30)
    tree.add("Dumb and Dumber", 10)
    tree.add("Beetlejuice", 40)
    tree.add("Batman Returns", 25)
    tree.add("Darkman", 80)

    expected = [{"Dumb and Dumber" => 10},
                {"Batman Returns" => 25},
                {"Mission Impossible" => 30},
                {"Beetlejuice" => 40},
                {"Darkman" => 80}]

    assert_equal expected, tree.sort()
  end

  def test_tree_can_read_file
    tree = BinaryTree.new
    file = "movies.txt"

    assert_equal 99, tree.load(file)
  end

  def test_tree_ignores_duplicates
    tree = BinaryTree.new
    file = "movies.txt"
    tree.add("Cruel Intentions", 0)

    assert_equal 98, tree.load(file)
  end

  def test_tree_counts_total_nodes
    tree = BinaryTree.new
    tree.add("Mission Impossible", 30)
    tree.add("Dumb and Dumber", 10)
    tree.add("Beetlejuice", 40)
    tree.add("Batman Returns", 25)
    tree.add("Darkman", 80)

    assert_equal 5, tree.total_nodes
  end

  def test_tree_can_count_node_and_children
    tree = BinaryTree.new
    tree.add("Mission Impossible", 30)
    tree.add("Dumb and Dumber", 10)
    tree.add("Beetlejuice", 40)
    tree.add("Batman Returns", 25)
    tree.add("Darkman", 80)
    node = tree.root.right_link

    assert_equal 2, tree.count_node_and_children(node)
  end

  def test_tree_can_assess_health
    tree = BinaryTree.new
    tree.add("Mission Impossible", 30)
    tree.add("Dumb and Dumber", 10)
    tree.add("Beetlejuice", 40)
    tree.add("Batman Returns", 25)
    tree.add("Darkman", 80)

    assert_equal [[10, 2, 40], [40, 2, 40]], tree.health(1)
  end

  def test_tree_health_on_larger_number
    tree = BinaryTree.new
    tree.add("Mission Impossible", 30)
    tree.add("Dumb and Dumber", 10)
    tree.add("Beetlejuice", 40)
    tree.add("Batman Returns", 25)
    tree.add("Darkman", 80)
    tree.add("Wall Street", 2)
    tree.add("Jungle Book", 28)

    assert_equal [[2, 1, 14], [25, 2, 28], [80, 1, 14]], tree.health(2)
  end
end
