def distance(a, b)
  (a[0] - b[0]) ** 2 + (a[1] - b[1]) ** 2 +  (a[2] - b[2]) ** 2
end

boxes = STDIN.read.split("\n").map { |x| x.split(",").map(&:to_i) }
num_connections_to_make = boxes.length == 20 ? 10 : 1000
pairs_by_distance = []
boxes.length.times do |i|
  (i+1..(boxes.length-1)).each do |j|
    pairs_by_distance << [distance(boxes[i], boxes[j]), [i, j]]
  end
end

pairs_by_distance.sort_by! { |x| x[0] }

# Part 1
graph = {}
boxes.length.times do |i|
  graph[i] = []
end
pairs_by_distance[0, num_connections_to_make].each do |dist, pair|
  i, j = pair
  graph[i] << j
  graph[j] << i
end

def cc(graph)
  def dfs(graph, visited, i)
    return [] if visited.include?(i)
    visited << i

    result = [i]
    graph[i].each do |j|
      result += dfs(graph, visited, j)
    end

    return result
  end

  visited = [].to_set
  components = []
  graph.keys.each do |i|
    next if visited.include?(i)
    components << dfs(graph, visited, i)
  end

  return components
end

components = cc(graph)
puts "Part 1: #{components.map(&:length).sort_by { |x| -x }[0, 3].inject(&:*)}"

# Part 2
networks = {}
next_network_id = 0
box_to_network = [nil] * boxes.length
num_networks = 0
boxes_seen = 0
pairs_by_distance.each_with_index do |pair_with_dist, num_connections_made|
  _, pair = pair_with_dist
  if num_connections_made == num_connections_to_make
    puts "Part 1 v2: #{box_to_network.to_set.reject { |x| x.nil? }.map { |x| networks[x] }.map(&:length).sort_by { |x| -x }[0, 3].inject(&:*)}"
  end

  i, j = pair
  if box_to_network[i].nil? && box_to_network[j].nil?
    networks[next_network_id] = [i, j]
    box_to_network[i] = next_network_id
    box_to_network[j] = next_network_id
    next_network_id += 1
    num_networks += 1
    boxes_seen += 2
  elsif box_to_network[i].nil?
    networks[box_to_network[j]] << i
    box_to_network[i] = box_to_network[j]
    boxes_seen += 1
  elsif box_to_network[j].nil?
    networks[box_to_network[i]] << j
    box_to_network[j] = box_to_network[i]
    boxes_seen += 1
  else
    next if box_to_network[i] == box_to_network[j]
    networks[box_to_network[j]].each do |x|
      networks[box_to_network[i]] << x
      box_to_network[x] = box_to_network[i]
    end
    num_networks -= 1
  end

  if boxes_seen == boxes.length && num_networks == 1
    puts "Part 2: #{boxes[i][0] * boxes[j][0]}"
    break
  end
end
