# typed: true

Move = Struct.new(:direction, :amount)

def parse(line)
  direction = line[0]
  amount = line[1, line.length - 1]
  Move.new(direction, amount.to_i)
end

pos = 50
total = 0
all_moves = []
while input = gets
  move = parse(input)
  all_moves << move
end

all_moves.each do |move|
  if move.direction == "L"
    pos -= move.amount
  elsif move.direction == "R"
    pos += move.amount
  end

  pos %= 100
  total += 1 if pos == 0
end
puts "Part 1: #{total}"

pos = 50
total = 0
pos_correct = 50
total_correct = 0
all_moves.each do |move|
  move.amount.times do
    pos_correct += (move.direction == "L" ? -1 : 1)
    pos_correct %= 100
    total_correct += 1 if pos_correct == 0
  end

  came_from_0 = pos == 0
  if move.direction == "L"
    pos -= move.amount
  elsif move.direction == "R"
    pos += move.amount
  end

  if pos == 0
    total += 1
  elsif pos < 0
    total += (pos / 100).abs
    total -= 1 if came_from_0
    total += 1 if (pos % 100 == 0) && !came_from_0
  elsif pos >= 100
    total += pos / 100
  end
  pos %= 100
end
puts "Part 2: #{total}"
puts "Part 2 (correct): #{total_correct}"
