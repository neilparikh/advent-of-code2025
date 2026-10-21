def parse(range)
  a, b = range.split("-")
  (a.to_i..b.to_i)
end

def is_silly(s, segements)
  segement_size = s.length / segements
  segement_size.times do |i|
    first = s[i]
    segements.times do |offset|
      return false if s[i+offset*segement_size] != first
    end
  end

  return true
end

input = gets.split(",")
total_1 = 0
total_2 = 0
input.each do |range|
  range = parse(range)
  range.each do |x|
    str = x.to_s
    (2..str.length).each do |i|
      next if str.length % i != 0
      if is_silly(str, i)
        total_1 += x if i == 2
        total_2 += x
        break
      end
    end
  end
end

puts "Part 1: #{total_1}"
puts "Part 2: #{total_2}"
