def merge_sort(array)
  return array if array.length < 2
  left = merge_sort(array[0...array.length/2])
  right = merge_sort(array[array.length/2..-1])
  merged = []

  until left.empty? && right.empty?
    if left.empty?
      merged << right.shift
    elsif right.empty?
      merged << left.shift
    elsif left[0] > right[0]
      merged << right.shift
    elsif left[0] < right[0]
      merged << left.shift
    end
  end

  return merged
end