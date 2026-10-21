def button_combos(buttons)
  1.upto(buttons.length).each do |n|
  end
end

def solve(lights, buttons)
  return button_combos do |c|
    break c.length if x == lights
  end
end

while input = gets
  lights, rest = input[1, input.length-1].strip.split("] ")
  lights = lights.split("").map { |x| x == "#" }
  buttons, rest = rest.split("{")
  buttons = buttons.split(" ").map { |x| x[1, x.length-2].split(",").map(&:to_i) }
  _joltage = rest[0, rest.length-1].split(",").map(&:to_i)
  puts solve(lights, buttons)
end
