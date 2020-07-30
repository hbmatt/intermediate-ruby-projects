class LinkedList
  attr_accessor :head, :tail

  def initialize(head = nil, tail = nil)
    @head = head
    @tail = tail
  end

  def append(value)
    if @head.nil?
      @head = Node.new(value)
      @tail = @head
    else
      new_node = Node.new(value)
      @tail.next_node = new_node
      @tail = new_node
    end

    puts self
  end

  def prepend(value)
    if @head.nil?
      @head = Node.new(value)
      @tail = Node.new(value)
    else
      @head = Node.new(value, @head)
    end

    puts self
  end

  def insert_at(value, index)
    return prepend(value) if index == 0

    current_index = 0
    current_node = @head

    until current_index == index - 1
      current_node = current_node.next_node
      current_index += 1
    end

    left_node = current_node

    return append(value) if left_node.next_node == @tail

    current_node = left_node.next_node
    right_node = current_node

    current_node = Node.new(value, right_node)
    left_node.next_node = current_node

    puts self
  end

  def remove_at(index)
    current_index = 0
    current_node = @head

    if index == 0
      @head = current_node.next_node
      current_node = nil
      return puts self
    end

    until current_index == index - 1
      current_node = current_node.next_node
      current_index += 1
    end

    left_node = current_node

    if left_node.next_node == @tail
      return pop
    else
      current_node = current_node.next_node
      right_node = current_node.next_node

      current_node = nil
      left_node.next_node = right_node
    end

    puts self
  end

  def size
    return 0 if @head.nil?

    counter = 1
    current_node = @head

    until current_node == @tail
      counter += 1
      current_node = current_node.next_node
    end

    counter
  end

  def at(index)
    current_index = 0
    current_node = @head

    until current_index == index
      current_index += 1
      current_node = current_node.next_node
    end

    return nil if current_node.nil?

    current_node.value
  end

  def pop
    if @head == @tail
      @head = nil
      @tail = nil
    else
      current_node = @head

      current_node = current_node.next_node until current_node.next_node == @tail

      @tail = current_node
      current_node.next_node = nil
    end

    puts self
  end

  def find(value)
    current_index = 0
    current_node = @head

    until value == current_node.value
      current_index += 1
      return nil if current_node == @tail

      current_node = current_node.next_node
    end

    current_index
  end

  def to_s
    return "'nil'" if @head.nil?

    current_node = @head
    result = ''

    until current_node.nil?
      result += "#{current_node.value} -> "
      current_node = current_node.next_node
    end

    result += "'nil'"
  end
end

class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end
