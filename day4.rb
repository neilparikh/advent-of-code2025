def remove_rolls(input)
  to_remove = []
  input.length.times do |i|
    input[i].length.times do |j|
      next if input[i][j] != "@"

      neighbour_count = 0
      [-1, 0, 1].each do |di|
        [-1, 0, 1].each do |dj|
          next if di == 0 && dj == 0
          next if i + di < 0 || j + dj < 0
          next if i + di >= input.length || j + dj > input[i + di].length

          neighbour_count += 1 if input[i + di][j + dj] == "@"
        end
      end

      if neighbour_count < 4
        to_remove << [i, j]
      end
    end
  end

  to_remove.each do |i, j|
    input[i][j] = "."
  end

  return to_remove.length
end

input = STDIN.read.split("\n")

num_removed = remove_rolls(input)
part1 = num_removed
total_removed = num_removed
while num_removed != 0
  num_removed = remove_rolls(input)
  total_removed += num_removed
end

puts "Part 1: #{part1}"
puts "Part 1: #{total_removed}"
