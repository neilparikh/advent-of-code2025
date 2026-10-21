input = STDIN.read.split("\n").map { |x| x.split(",").map(&:to_i) }
biggest = 0
input.length.times do |i|
  (i..input.length-1).each do |j|
    biggest = [biggest, (input[i][0] - input[j][0] + 1).abs * (input[i][1] - input[j][1] + 1)].max
  end
end

puts "Part 1: #{biggest}"
