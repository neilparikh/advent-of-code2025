input = STDIN.read.split("\n")
raw_nums = input[0, input.length-1]
ops = input.last.split(" ")

nums1 = raw_nums.map { |x| x.split(" ").map(&:to_i) }
part1 = 0
ops.length.times do |i|
  acc = ops[i] == "*" ? 1 : 0
  nums1.each do |row|
    if ops[i] == "*"
      acc *= row[i]
    else
      acc += row[i]
    end
  end
  part1 += acc
end

part2 = 0
curr_nums = []
max_len = raw_nums.map(&:length).max
raw_nums.map { |x| x.ljust(max_len, " ").split("") }.transpose.map(&:join).map(&:strip).each do |num|
  if num.empty?
    part2 += curr_nums.inject(&ops.shift.to_sym)
    curr_nums = []
  else
    curr_nums << num.to_i
  end
end
part2 += curr_nums.inject(&ops.shift.to_sym)

puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
