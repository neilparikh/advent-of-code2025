def solve(bank, a, num_digits)
  return 0 if num_digits == 0
  
  biggest_i = (a..(bank.length - num_digits)).max_by { |i| bank[i] }
  bank[biggest_i] * 10**(num_digits - 1) + solve(bank, biggest_i + 1, num_digits - 1)
end

total_1 = 0
total_2 = 0
while bank = gets
  bank = bank.strip.split('').map(&:to_i)

  total_1 += solve(bank, 0, 2)

  total_2 += solve(bank, 0, 12)
end

puts "Part 1: #{total_1}"
puts "Part 2: #{total_2}"
