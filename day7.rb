input = STDIN.read.split("\n")

start_state = (0..(input[0].length-1)).map { |i| input[0][i] == 'S' ? 1 : 0 }
state = [start_state]
(input.length - 1).times do
  state << [0] * input[0].length
end

num_split = 0
(1..input.length-1).each do |i|
  input[i].length.times do |j|
    if input[i][j] == "^"
      if state[i-1][j] > 0
        num_split += 1
        state[i+1][j-1] += state[i-1][j] if j > 0
        state[i+1][j+1] += state[i-1][j] if j < input[i].length - 1
      end
    else
      state[i][j] += state[i-1][j]
    end
  end
end

puts "Part 1: #{num_split}"
puts "Part 2: #{state.last.sum}"
