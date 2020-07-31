class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    return nil if array.length == 0

    array = array.sort.uniq
    midpoint = array[array.length / 2]
    root = Node.new(midpoint)

    return root if array.length == 1

    root.left = build_tree(array[0..array.length / 2 - 1])
    root.right = build_tree(array[array.length / 2 + 1..-1])

    root
  end

  def insert(value)
    current_node = @root
    new_node = Node.new(value)

    return @root if @root.nil?
    return false if find(value)

    until current_node.nil?
      parent_node = current_node
      current_node = value < current_node.value ? current_node.left : current_node.right
    end

    value < parent_node.value ? parent_node.left = new_node : parent_node.right = new_node
  end

  def delete(value)
    current_node = @root

    until current_node.value == value
      parent_node = current_node
      current_node = value < current_node.value ? current_node.left : current_node.right
    end

    if current_node.left && current_node.right
      if current_node.value < parent_node.value
        replacement = current_node.left
        replacement.right = current_node.right
        parent_node.left = replacement
      elsif current_node.value > parent_node.value
        replacement = current_node.right
        replacement.left = current_node.left
        parent_node.right = replacement
      end
    else
      replacement = current_node.left || current_node.right || nil
      current_node.value < parent_node.value ? parent_node.left = replacement : parent_node.right = replacement
    end

    current_node
  end

  def find(value)
    current_node = @root

    until current_node.value == value
      current_node = value < current_node.value ? current_node.left : current_node.right
      return false if current_node.nil?
    end

    current_node
  end

  def level_order(queue = [@root], order = [])
    current_node = queue.shift

    return if current_node.nil?

    order << current_node.value
    queue << current_node.left unless current_node.left.nil?
    queue << current_node.right unless current_node.right.nil?

    level_order(queue, order)

    order
  end

  def inorder(current_node = @root, order = [])
    return if current_node.nil?

    inorder(current_node.left, order)
    order << current_node.value
    inorder(current_node.right, order)

    order
  end

  def preorder(current_node = @root, order = [])
    return if current_node.nil?

    order << current_node.value
    preorder(current_node.left, order)
    preorder(current_node.right, order)

    order
  end

  def postorder(current_node = @root, order = [])
    return if current_node.nil?

    postorder(current_node.left, order)
    postorder(current_node.right, order)
    order << current_node.value

    order
  end

  def depth(node)
    return if node.nil?

    left_depth = node.left.nil? ? 0 : (1 + depth(node.left))
    right_depth = node.right.nil? ? 0 : (1 + depth(node.right))

    depth = left_depth > right_depth ? left_depth : right_depth
  end

  def balanced?
    return true if depth(@root.left) - depth(@root.right) <= 1 && depth(@root.left) - depth(@root.right) >= -1

    false
  end

  def rebalance
    array = level_order
    @root = build_tree(array)
  end
end

puts 'Creating new tree.'
test_tree = Tree.new(Array.new(15) { rand(1..100) })
puts "Tree balanced? #{test_tree.balanced?}\n\n"

puts 'Level Order:'
p test_tree.level_order
puts 'Preorder:'
p test_tree.preorder
puts 'Postorder:'
p test_tree.postorder
puts 'Inorder:'
p test_tree.inorder

test_tree.insert(500)
test_tree.insert(900)
test_tree.insert(300)
test_tree.insert(250)
test_tree.insert(450)

puts "\nTree balanced? #{test_tree.balanced?}"
puts 'Rebalancing tree.'
test_tree.rebalance
puts "Tree balanced? #{test_tree.balanced?}\n\n"

puts 'Level Order:'
p test_tree.level_order
puts 'Preorder:'
p test_tree.preorder
puts 'Postorder:'
p test_tree.postorder
puts 'Inorder:'
p test_tree.inorder
