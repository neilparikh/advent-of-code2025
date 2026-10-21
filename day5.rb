def merge_intervals(intervals)
  result = []
  intervals.sort_by { |s, e| s }.each do |s, e|
    if result.empty? || result[-1][1] < s
      result << [s, e]
    else
      result[-1][1] = [result[-1][1], e].max
    end
  end

  result
end

fresh, available = STDIN.read.split("\n\n")
available = available.split("\n").map(&:to_i)
fresh = merge_intervals(fresh.split("\n").map { |x| x.split("-").map(&:to_i) })

part1 = available.filter { |x| fresh.any? { |s, e| x >= s && x <= e } }.length

part2 = fresh.map { |s, e| e - s + 1 }.sum

puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
